// import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY")!;

// Deno.serve(async (req) => {
//   if (req.method === "OPTIONS") {
//     return new Response("ok", {
//       headers: {
//         "Access-Control-Allow-Origin": "*",
//         "Access-Control-Allow-Headers": "authorization, content-type",
//       },
//     });
//   }

//   try {
//     const { messages } = await req.json();

//     const formattedMessages = messages.map((msg: any) => {
//       if (msg.imageBase64) {
//         return {
//           role: msg.role,
//           content: [
//             {
//               type: "image_url",
//               image_url: {
//                 url: `data:image/jpeg;base64,${msg.imageBase64}`,
//               },
//             },
//             ...(msg.content ? [{ type: "text", text: msg.content }] : []),
//           ],
//         };
//       }
//       return {
//         role: msg.role,
//         content: msg.content, // ✅ غيرنا msg.text → msg.content
//       };
//     });

//     console.log("Sending to OpenAI:", JSON.stringify(formattedMessages));

//     const response = await fetch("https://api.openai.com/v1/chat/completions", {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": `Bearer ${OPENAI_API_KEY}`,
//       },
//       body: JSON.stringify({
//         model: "gpt-4o-mini",
//         messages: formattedMessages,
//         max_tokens: 500,
//       }),
//     });

//     const data = await response.json();
//     console.log("OpenAI response:", JSON.stringify(data)); // ✅

//     if (!data.choices || data.choices.length === 0) {
//       throw new Error(`OpenAI error: ${JSON.stringify(data)}`);
//     }

//     const reply = data.choices[0].message.content;

//     return new Response(JSON.stringify({ reply }), {
//       headers: {
//         "Content-Type": "application/json",
//         "Access-Control-Allow-Origin": "*",
//       },
//     });
//   } catch (e) {
//     return new Response(JSON.stringify({ error: e.message }), {
//       status: 500,
//       headers: {
//         "Content-Type": "application/json",
//         "Access-Control-Allow-Origin": "*",
//       },
//     });
//   }
// });

// import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY")!;

// Deno.serve(async (req) => {
//   // التعامل مع طلبات CORS المسبقة (preflight)
//   if (req.method === "OPTIONS") {
//     return new Response("ok", {
//       headers: {
//         "Access-Control-Allow-Origin": "*",
//         "Access-Control-Allow-Headers": "authorization, content-type",
//       },
//     });
//   }

//   try {
//     // 1. قراءة البيانات من الطلب
//     const { messages } = await req.json();
    
//     // 2. استخراج آخر رسالة من المستخدم
//     let userText = "Hello";
//     if (messages && messages.length > 0) {
//       const lastMsg = messages[messages.length - 1];
//       userText = lastMsg.content || "Hello";
//     }

//     console.log("Sending to OpenAI:", userText);

//     // 3. إرسال الطلب إلى OpenAI API
//     const response = await fetch("https://api.openai.com/v1/chat/completions", {
//       method: "POST",
//       headers: {
//         "Authorization": `Bearer ${OPENAI_API_KEY}`,
//         "Content-Type": "application/json",
//       },
//       body: JSON.stringify({
//         model: "gpt-3.5-turbo",
//         messages: [{ role: "user", content: userText }],
//         max_tokens: 300,
//       }),
//     });

//     const data = await response.json();

//     // 4. التحقق من نجاح الطلب
//     if (!response.ok) {
//       console.error("OpenAI API error:", data);
//       throw new Error(data.error?.message || "OpenAI API request failed");
//     }

//     // 5. استخراج الرد
//     const reply = data.choices[0].message.content;

//     // 6. إرجاع الرد الناجح
//     return new Response(JSON.stringify({ reply }), {
//       headers: {
//         "Content-Type": "application/json",
//         "Access-Control-Allow-Origin": "*",
//       },
//     });

//   } catch (error) {
//     // 7. معالجة الأخطاء وإرجاع رسالة مفهومة
//     console.error("Function error:", error.message);
    
//     return new Response(
//       JSON.stringify({ 
//         error: error.message,
//         reply: "I'm having trouble right now. Please try again."
//       }),
//       {
//         status: 200, // استخدام 200 لمنع ظهور 500 في المتصفح
//         headers: {
//           "Content-Type": "application/json",
//           "Access-Control-Allow-Origin": "*",
//         },
//       }
//     );
//   }
// });

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
// import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY")!;

// Deno.serve(async (req) => {
//   // CORS preflight
//   if (req.method === "OPTIONS") {
//     return new Response("ok", {
//       headers: {
//         "Access-Control-Allow-Origin": "*",
//         "Access-Control-Allow-Headers": "authorization, content-type",
//         "Access-Control-Allow-Methods": "POST, OPTIONS",
//       },
//     });
//   }

//   // ✅ التحقق من وجود API key
//   if (!GEMINI_API_KEY) {
//     console.error("GEMINI_API_KEY is not set");
//     return new Response(
//       JSON.stringify({ error: "Server configuration error", reply: "عذراً، هناك خطأ في تكوين الخادم" }),
//       {
//         status: 500,
//         headers: {
//           "Content-Type": "application/json",
//           "Access-Control-Allow-Origin": "*",
//         },
//       }
//     );
//   }

//   try {
//     const { messages } = await req.json();
    
//     console.log("📨 Received messages:", JSON.stringify(messages, null, 2));
    
//     if (!messages || messages.length === 0) {
//       return new Response(
//         JSON.stringify({ reply: "مرحباً! كيف يمكنني مساعدتك في الزراعة؟" }),
//         {
//           headers: {
//             "Content-Type": "application/json",
//             "Access-Control-Allow-Origin": "*",
//           },
//         }
//       );
//     }
    
//     // ✅ بناء المحادثة لتنسيق Gemini
//     let conversationContext = `أنت مساعد زراعي خبير. أجب باللغة العربية. 
// قدم إجابات قصيرة ومباشرة وعملية. لا تقدم معلومات غير زراعية.
// إذا سُئلت عن شيء خارج الزراعة، قل بلطف أن تخصصك هو الزراعة فقط.

// `;
    
//     // ✅ إضافة تاريخ المحادثة
//     for (let i = 0; i < messages.length; i++) {
//       const msg = messages[i];
//       if (msg.content && msg.content.trim() !== "") {
//         const role = msg.role === "assistant" ? "المساعد" : "المستخدم";
//         conversationContext += `${role}: ${msg.content}\n`;
//       }
//     }
    
//     conversationContext += "المساعد: ";
    
//     console.log("📤 Sending to Gemini:", conversationContext);
    
//     // ✅ إرسال الطلب إلى Gemini API
// const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`;    
//     const response = await fetch(geminiUrl, {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//       },
//       body: JSON.stringify({
//         contents: [{
//           parts: [{
//             text: conversationContext
//           }]
//         }],
//         generationConfig: {
//           temperature: 0.7,
//           maxOutputTokens: 300,
//           topP: 0.95,
//           topK: 40,
//         },
//         safetySettings: [
//           {
//             category: "HARM_CATEGORY_HARASSMENT",
//             threshold: "BLOCK_MEDIUM_AND_ABOVE"
//           },
//           {
//             category: "HARM_CATEGORY_HATE_SPEECH",
//             threshold: "BLOCK_MEDIUM_AND_ABOVE"
//           },
//           {
//             category: "HARM_CATEGORY_SEXUALLY_EXPLICIT",
//             threshold: "BLOCK_MEDIUM_AND_ABOVE"
//           },
//           {
//             category: "HARM_CATEGORY_DANGEROUS_CONTENT",
//             threshold: "BLOCK_MEDIUM_AND_ABOVE"
//           }
//         ]
//       }),
//     });

//     const data = await response.json();
    
//     console.log("📥 Gemini response:", JSON.stringify(data, null, 2));
    
//     if (!response.ok) {
//       console.error("Gemini API error:", data);
      
//       // ✅ رسالة خطأ مفيدة
//       let errorMessage = "عذراً، حدث خطأ. يرجى المحاولة مرة أخرى.";
//       if (data.error?.message?.includes("API key")) {
//         errorMessage = "خطأ في إعدادات التطبيق. يرجى التواصل مع الدعم.";
//       } else if (data.error?.message) {
//         errorMessage = `خطأ: ${data.error.message}`;
//       }
      
//       return new Response(
//         JSON.stringify({ reply: errorMessage }),
//         {
//           status: 200, // استخدام 200 لتجنب مشاكل CORS
//           headers: {
//             "Content-Type": "application/json",
//             "Access-Control-Allow-Origin": "*",
//           },
//         }
//       );
//     }

//     // ✅ استخراج الرد
//     let reply = data.candidates?.[0]?.content?.parts?.[0]?.text || "";
    
//     // ✅ تنظيف الرد
//     reply = reply
//       .replace(/^المساعد:\s*/i, '')
//       .replace(/^Assistant:\s*/i, '')
//       .trim();
    
//     if (!reply || reply === "") {
//       reply = "عذراً، لم أتمكن من معالجة طلبك. يرجى إعادة الصياغة.";
//     }
    
//     console.log("✅ Final reply:", reply);

//     return new Response(
//       JSON.stringify({ reply: reply }),
//       {
//         headers: {
//           "Content-Type": "application/json",
//           "Access-Control-Allow-Origin": "*",
//         },
//       }
//     );
    
//   } catch (e) {
//     console.error("❌ Function error:", e);
    
//     return new Response(
//       JSON.stringify({ 
//         reply: "عذراً، حدث خطأ في الخادم. يرجى المحاولة مرة أخرى.",
//         error: e.message 
//       }),
//       {
//         status: 200,
//         headers: {
//           "Content-Type": "application/json",
//           "Access-Control-Allow-Origin": "*",
//         },
//       }
//     );
//   }
// });