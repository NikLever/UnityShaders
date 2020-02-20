using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RevealController : MonoBehaviour
{
    public Material material;

    float _RevealTime;

    private void Update()
    {
        if (material!=null && _RevealTime!=null)
        {
            material.SetFloat("_RevealTime", Time.time - _RevealTime);
        }
    }

    public void RevealClicked()
    {
        _RevealTime = Time.time;
    }
}
