using UnityEngine;

[ExecuteInEditMode]
public class Scene70RenderImage : MonoBehaviour
{
    #region Variables
    public Shader curShader;
    public float tint = 1.0f;
    public int scanlines = 100;
    private Material screenMat;
    #endregion

    #region
    Material ScreenMat
    {
        get
        {
            if (screenMat == null)
            {
                screenMat = new Material(curShader);
                screenMat.hideFlags = HideFlags.HideAndDontSave;
            }

            return screenMat;
        }
    }
    #endregion

    // Start is called before the first frame update
    void Start()
    {
        if (!curShader && !curShader.isSupported)
        {
            enabled = false;
        }
    }

    void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
    {
        if (curShader != null)
        {
            ScreenMat.SetFloat("_Tint", tint);
            ScreenMat.SetFloat("_Scanlines", scanlines);
            Graphics.Blit(sourceTexture, destTexture, ScreenMat);
        }
        else
        {
            Graphics.Blit(sourceTexture, destTexture);
        }
    }
    // Update is called once per frame
    void Update()
    {
        tint = Mathf.Clamp(tint, 0.0f, 1.0f);
    }

    private void OnDisable()
    {
        if (screenMat)
        {
            DestroyImmediate(screenMat);
        }
    }
}
