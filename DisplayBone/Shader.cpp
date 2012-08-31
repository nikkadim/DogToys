#include "Shader.h"

Shader::Shader()
{
    m_shaderID = 0;
}

Shader::Shader(GLenum shaderType, const string &filename)
{
    m_shaderID = 0;
    init(shaderType, filename);
}

Shader::~Shader()
{
    glDeleteShader(m_shaderID);
}

bool Shader::init(GLenum shaderType, const string &filename)
{
    bool shaderCreated = false;
    m_shaderID = glCreateShader(shaderType);

    const GLchar* shaderSource = _loadShaderSource(filename);

    if (shaderSource == NULL)
    {
        printf("Shader source file not found: %s\n", filename.c_str());
    }
    else
    {
        bool shaderCompileFlag = false;

        glShaderSource(m_shaderID, 1, &shaderSource, 0);

        glCompileShader(m_shaderID);
        shaderCompileFlag = _validateShader(m_shaderID, filename);
        if (!shaderCompileFlag) return false;

    }

    if(NULL != shaderSource)
    {
        delete[] shaderSource;
    }


    return shaderCreated;
}

GLuint Shader::shaderID(void)
{
    return m_shaderID;
}

char* Shader::_loadShaderSource(const string &filename)
{
    char* shaderSource;

    ifstream shaderFile;
    shaderFile.open(filename.c_str(), ios::in | ios::binary | ios::ate);

    if(shaderFile.is_open())
    {
        //	Get the size of the file
        long size = shaderFile.tellg();

        //	If there is source read it in
        if (size > 0)
        {
            //	Reset back to the beginning of the file
            shaderFile.seekg(0, ios::beg);

            //	Read in all the source
            shaderSource = new char[size + 1];
            shaderFile.read(shaderSource, size);
            shaderSource[size] = '\0';
        }
        //	Dont forget to close the file
        shaderFile.close();
    }

    return shaderSource;
}

bool Shader::_validateShader(GLuint shader, const string &filename = "")
{
    bool validShader = false;

    const unsigned int BUFFER_SIZE = 512;
    char buffer[BUFFER_SIZE];
    memset(buffer, 0, BUFFER_SIZE);
    GLsizei length = 0;

    glGetShaderInfoLog(shader, BUFFER_SIZE, &length, buffer);
    validShader = length <= 0;

    if (!validShader)
    {
        printf("Error compiling shader: %s\n", filename.c_str());
        //printf(string(buffer));
    }

    return validShader;
}