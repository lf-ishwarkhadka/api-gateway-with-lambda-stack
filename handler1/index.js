module.exports.handler = async (event) => {  
  console.log('Event: ', event);  
  let responseMessage = 'Hello, World! This is lambda function1';  
  return {    statusCode: 200,    
    headers: {     
      'Content-Type': 'application/json',    
    },    
    body: JSON.stringify({      
      message: responseMessage,    
    }),  
  }
}