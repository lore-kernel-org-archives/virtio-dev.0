Return-Path: virtio-comment-return-1501-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jie Deng <jie.deng@intel.com>
References: <61930337391bdfd23ed164288d998c04177bc839.1603435652.git.jie.deng@intel.com>
 <20201023115932-mutt-send-email-mst@kernel.org>
 <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
 <20201027071957-mutt-send-email-mst@kernel.org>
 <d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com>
 <a7c27a1d-eca7-f0a6-0bcc-4fdbb9d7a001@intel.com>
Message-ID: <7f972463-35ed-e3a8-065a-5fe649827993@intel.com>
Date: Tue, 10 Nov 2020 15:31:43 +0800
MIME-Version: 1.0
In-Reply-To: <a7c27a1d-eca7-f0a6-0bcc-4fdbb9d7a001@intel.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v2] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------3E30C0FFC930758F9F723275"
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------3E30C0FFC930758F9F723275
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/11/5 14:35, Jie Deng wrote:
>
>
> On 2020/10/31 21:58, Paolo Bonzini wrote:
>> On 27/10/20 12:20, Michael S. Tsirkin wrote:
>>>> The I2C doesn't support segments numbering and sorting.
>>>> So if one creates a multi-segment transaction, then he/she should keep=
 the
>>>> segments in order.
>>>>
>>>> Thanks.
>>> Fine, but I see no flags to signal start/end of such a transaction.
>>>
>> In theory there's no difference between one multi-segment transaction
>> and many single-segment transactions _in a single-master scenario_.
>>
>> However, it is a plausible configuration to have multiple guests sharing
>> an I2C host device as if they were multiple master.
>>
>> For this reason, I would prefer to have at least support for
>> transactions with 1 write and 1 read segment to the same address (see my
>> other message).
>>
>> Paolo
> Then how to distinguish the order of the two segments if they are in=20
> one request ?
> We don't know this is a write followed by a read or a read followed by=20
> a write in this case.
>
> However, if the request is the representation of only one segment of=20
> an I2C transaction,
> we can simply judge by the order of the requests in the virtqueue.
>
> Thanks
>
I didn't see any response so I updated a v4 to have following simplest=20
request for this moment.

struct virtio_i2c_req {
 =C2=A0=C2=A0=C2=A0 le16 addr;
 =C2=A0=C2=A0=C2=A0 le16 len;
 =C2=A0=C2=A0=C2=A0 u8 buf[];
 =C2=A0=C2=A0=C2=A0 u8 status;
};

Thanks.


--------------3E30C0FFC930758F9F723275
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2020/11/5 14:35, Jie Deng wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:a7c27a1d-eca7-f0a6-0bcc-4fdbb9d7a001@intel.com">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <p><br>
      </p>
      <div class=3D"moz-cite-prefix">On 2020/10/31 21:58, Paolo Bonzini
        wrote:<br>
      </div>
      <blockquote type=3D"cite"
        cite=3D"mid:d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com">
        <pre class=3D"moz-quote-pre" wrap=3D"">On 27/10/20 12:20, Michael S=
. Tsirkin wrote:
</pre>
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">The I2C doesn't support =
segments numbering and sorting.
So if one creates a multi-segment transaction, then he/she should keep the
segments in order.

Thanks.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">Fine, but I see no flags t=
o signal start/end of such a transaction.

</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">In theory there's no differe=
nce between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.

For this reason, I would prefer to have at least support for
transactions with 1 write and 1 read segment to the same address (see my
other message).

Paolo
</pre>
      </blockquote>
      Then how to distinguish the order of the two segments if they are
      in one request ?<br>
      We don't know this is a write followed by a read or a read
      followed by a write in this case.<br>
      <span class=3D"fontstyle0"></span><br>
      <span class=3D"fontstyle0">However, if the request is the
        representation of only one segment of an I2C transaction,</span><br=
>
      <span class=3D"fontstyle0">we can simply judge by the order of the
        requests in the virtqueue.</span>
      <p><span class=3D"fontstyle0">Thanks<br>
        </span></p>
    </blockquote>
    <p>I didn't see any response so I updated a v4 to have following
      simplest request for this moment.<br>
    </p>
    <p><span class=3D"fontstyle0">struct virtio_i2c_req {<br>
        =C2=A0=C2=A0=C2=A0 le16 addr;<br>
        =C2=A0=C2=A0=C2=A0 le16 len;<br>
        =C2=A0=C2=A0=C2=A0 u8 buf[];<br>
        =C2=A0=C2=A0=C2=A0 u8 status;<br>
        };</span> <br style=3D" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
    <p>Thanks.<br>
    </p>
  </body>
</html>

--------------3E30C0FFC930758F9F723275--

