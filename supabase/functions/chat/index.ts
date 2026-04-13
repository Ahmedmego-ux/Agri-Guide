
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

const GROQ_API_KEY = Deno.env.get("GROQ_API_KEY")!;

Deno.serve(async (req) => {
  // CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "authorization, content-type",
      },
    });
  }

  try {
    const { messages } = await req.json();
    
    if (!messages || messages.length === 0) {
      return new Response(
        JSON.stringify({ reply: "Hello! How can I help you with agriculture?" }),
        {
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        }
      );
    }
    
    // تحويل الرسائل إلى صيغة Groq
    const formattedMessages = [];
    
    formattedMessages.push({
      role: "system",
      content: "You are an agricultural expert. Provide short, direct answers. No extra text."
    });
    
    for (const msg of messages) {
      if (msg.content && msg.content.trim() !== "") {
        formattedMessages.push({
          role: msg.role === "assistant" ? "assistant" : "user",
          content: msg.content
        });
      }
    }
    
    const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${GROQ_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "llama-3.3-70b-versatile",
        messages: formattedMessages,
        temperature: 0.5,
        max_tokens: 150,
      }),
    });

    const data = await response.json();
    
    if (!response.ok) {
      console.error("Groq API error:", data);
      throw new Error(data.error?.message || "API error");
    }

    const reply = data.choices[0].message.content;

    return new Response(
      JSON.stringify({ reply }),
      {
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      }
    );
    
  } catch (e) {
    console.error("Function error:", e);
    
    return new Response(
      JSON.stringify({ reply: "Please try again." }),
      {
        status: 200,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      }
    );
  }
});
