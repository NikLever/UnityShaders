using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIHandler : MonoBehaviour
{
    public GameObject quad;
    public List<Texture> images;
    private int index;
    private Material material;

    // Start is called before the first frame update
    void Start()
    {
        index = 0;

        if (quad != null)
        {
            material = quad.GetComponent<Renderer>().material;
            material.SetFloat("_StartTime", Time.time);
            NextClicked();
        }
    }

    public void NextClicked()
    {
        if (material == null) return;
        index++;
        if (index >= images.Count) index = 0;
        if (index == 0)
        {
            material.SetTexture("_TextureA", images[images.Count - 1]);
            material.SetTexture("_TextureB", images[index]);
        }
        else
        {
            material.SetTexture("_TextureA", images[index-1]);
            material.SetTexture("_TextureB", images[index]);
        }
        
        material.SetFloat("_StartTime", Time.time);
    }
}
