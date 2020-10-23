Return-Path: virtio-comment-return-1467-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <7e62cac21047d1692edea06c1fd917faea53087f.1600742717.git.jie.deng@intel.com>
 <20201021080250-mutt-send-email-mst@kernel.org>
 <0525fa7b-fdb4-fb8d-dac7-7aad143fc380@intel.com>
 <20201022081313-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <e43a65c2-c7e4-18ab-e0f1-55bf3e324c5a@intel.com>
Date: Fri, 23 Oct 2020 15:03:43 +0800
MIME-Version: 1.0
In-Reply-To: <20201022081313-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH] virtio-i2c: add the device specification
Content-Type: multipart/alternative;
 boundary="------------ECEC3A4E8A84F91CB9A04FF8"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--------------ECEC3A4E8A84F91CB9A04FF8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2020/10/22 20:15, Michael S. Tsirkin wrote:

> On Thu, Oct 22, 2020 at 03:45:16PM +0800, Jie Deng wrote:
>
> does "use the message" mean? What message?
>> I mean=C3=82=C2=A0 the "addr", "flags" , "len " and "buf " in "virtio_i2=
c_req" here.
>> I will describe it more precisely in v2.
>>
>> Thanks.
>
> Right. For example it is very unclear what does the
> buffer map to.  a single i2c_msg? then do we not need STOP
> etc etc ... ?
>
Yes. virtio_i2c_req is just a wrap of i2c_msg.
I have updated the v2 hoping that the description will look more precise.

Thanks.


--------------ECEC3A4E8A84F91CB9A04FF8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p>On 2020/10/22 20:15, Michael S. Tsirkin wrote:<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201022081313-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Oct 22, 2020 at 03:45:=
16PM +0800, Jie Deng wrote:
</pre>
      <br>
      <pre class=3D"moz-quote-pre" wrap=3D"">does "use the message" mean? W=
hat message?
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">I mean=C3=82=C2=A0 the "addr=
", "flags" , "len " and "buf " in "virtio_i2c_req" here.
I will describe it more precisely in v2.

Thanks.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">

Right. For example it is very unclear what does the
buffer map to.  a single i2c_msg? then do we not need STOP
etc etc ... ?

</pre>
    </blockquote>
    Yes. <span class=3D"fontstyle0">virtio_i2c_req</span> is just a wrap
    of i2c_msg.<br>
    I have updated the v2 hoping that the description will look more
    precise.<br>
    <p>Thanks.</p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201022081313-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------ECEC3A4E8A84F91CB9A04FF8--

