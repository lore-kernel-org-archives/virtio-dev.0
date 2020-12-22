Return-Path: virtio-comment-return-1580-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
 <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
 <20201217030015-mutt-send-email-mst@kernel.org>
 <20201217102640.GG4338@stefanha-x1.localdomain>
 <1ccc5889-4e28-deac-8168-c6f0665231c1@intel.com>
 <20201218155526-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <20b91229-e938-66fb-464b-c85c1dbcde96@intel.com>
Date: Tue, 22 Dec 2020 14:11:24 +0800
MIME-Version: 1.0
In-Reply-To: <20201218155526-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------38126D33142EC29995F94C76"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------38126D33142EC29995F94C76
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/12/20 3:05, Michael S. Tsirkin wrote:
> On Fri, Dec 18, 2020 at 10:06:45AM +0800, Jie Deng wrote:
>> On 2020/12/17 18:26, Stefan Hajnoczi wrote:
>>> On Thu, Dec 17, 2020 at 03:00:55AM -0500, Michael S. Tsirkin wrote:
>>>> On Thu, Dec 17, 2020 at 03:08:07PM +0800, Jie Deng wrote:
>>>>>           +The \field{flags} of the request is currently reserved as =
zero for future
>>>>>           +feature extensibility.
>>>>>           +
>>>>>           +The \field{written} of the request is the number of data b=
ytes in the \field{write_buf}
>>>>>           +being written to the I2C slave address.
>>>>>
>>>>>       This field seems redundant since the device can determine the s=
ize of
>>>>>       write_buf implicitly from the total out buffer size. virtio-blk=
 takes
>>>>>       this approach.
>>>>>
>>>>> The read/write are the actual number of data bytes being read from or=
 written
>>>>> to the device
>>>>> which is not determined by the device. So I don't think it is redunda=
nt.
>>>> I am still not sure I understand the difference.
>>>> This point is unclear to multiple people.
>>> I think I get it now. This is made clear by splitting the struct:
>>>
>>>     /* Driver->device fields */
>>>     struct virtio_i2c_out_hdr
>>>     {
>>>         le16 addr;
>>>         le16 padding;
>>>         le32 flags;
>>>     };
>>>
>>>     /* Device->driver fields */
>>>     struct virtio_i2c_in_hdr
>>>     {
>>>         le16 written;
>>>         le16 read;
>>>         u8 status;
>>>     };
>> written/read are not device->driver fields. They are driver->device fiel=
ds.
>> They are not determined by the device but the driver(user).
>>
>> However, Michael said that the two fields may duplicate buf size availab=
le
>> in the descriptor. He intended to remove them.
>>
>> "
>> I note that read and written actually duplicate buf size
>> available in the descriptor.
>> Given we no longer mirror i2c_msg 1:1 do we still want to do this?
>> It will be trivial for the host device to populate these fields
>> correctly for linux.
>> Duplication of information iten leads to errors ...
>> "
>>
>> But there is a corner case I'm not sure if you have noticed.
>>
>> read and written can be 0. I think we may not put a buf with size 0 into=
 the
>> virtqueue.
> You always have the header and the status, right?
> E.g. with the below, the total buffer size is virtio_i2c_out_hdr size +
> write size for writes and read size + virtio_i2c_in_hdr size for reads.
> Neither result is ever 0.

Then how to distinguish the request type the buffer contains.

Each type will have both virtio_i2c_out_hdr and virtio_i2c_in_hdr.
the backend can know the type by checking the read/written.

If the read=3D0 and the written>0, the request is a write request
The buffer may contains 3 scatterlist:

virtio_i2c_out_hdr // scatterlist[0]

 =C2=A0=C2=A0=C2=A0 buf[/* this is write data, since read =3D 0 */] // scat=
terlist[1]

 =C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr // scatterlist[2]

If the read>0 and the written=3D0, the request is a read request.
The buffer may contains 3 scatterlist:

virtio_i2c_out_hdr // scatterlist[0]

 =C2=A0=C2=A0=C2=A0 buf[/* This is read data, since written =3D 0 */] // sc=
atterlist[1]

 =C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr // scatterlist[2]

If the read>0 and the written>0, the request is a write-read request.
The buffer may contains 4 scatterlist:

virtio_i2c_out_hdr=C2=A0=C2=A0 // scatterlist[0]

 =C2=A0=C2=A0=C2=A0 buf[/*write data*/]=C2=A0 // scatterlist[1]

 =C2=A0=C2=A0=C2=A0 buf[/*read data*/] // scatterlist[2]

 =C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr // scatterlist[3]

>> @Stefan @Paolo
>>
>> So what's your opinion about these two fields ?
>>
>>>     /*
>>>      * Virtqueue element layout looks like this:
>>>      *
>>>      * struct virtio_i2c_out_hdr out_hdr; /* OUT */
>>>      * u8 write_buf[]; /* OUT */
>>>      * u8 read_buf[]; /* IN */
>>>      * struct virtio_i2c_in_hdr in_hdr; /* IN */
>>>      */
>>>
>>> This makes sense to me: a bi-directional request has both write_buf[]
>>> and read_buf[] so the vring used.len field is not enough to report back
>>> how many bytes were written and read. The virtio_i2c_in_hdr fields are
>>> really needed.
>>>
>>> Please split the struct in the spec so it's clear how this works.

--------------38126D33142EC29995F94C76
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
    <div class=3D"moz-cite-prefix">On 2020/12/20 3:05, Michael S. Tsirkin
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20201218155526-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Fri, Dec 18, 2020 at 10:06:=
45AM +0800, Jie Deng wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">
On 2020/12/17 18:26, Stefan Hajnoczi wrote:
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Dec 17, 2020 at 03=
:00:55AM -0500, Michael S. Tsirkin wrote:
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Dec 17, 2020 at =
03:08:07PM +0800, Jie Deng wrote:
</pre>
            <blockquote type=3D"cite">
              <pre class=3D"moz-quote-pre" wrap=3D"">
         +The \field{flags} of the request is currently reserved as zero fo=
r future
         +feature extensibility.
         +
         +The \field{written} of the request is the number of data bytes in=
 the \field{write_buf}
         +being written to the I2C slave address.

     This field seems redundant since the device can determine the size of
     write_buf implicitly from the total out buffer size. virtio-blk takes
     this approach.

The read/write are the actual number of data bytes being read from or writt=
en
to the device
which is not determined by the device. So I don't think it is redundant.
</pre>
            </blockquote>
            <pre class=3D"moz-quote-pre" wrap=3D"">I am still not sure I un=
derstand the difference.
This point is unclear to multiple people.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">I think I get it now. This=
 is made clear by splitting the struct:

   /* Driver-&gt;device fields */
   struct virtio_i2c_out_hdr
   {
       le16 addr;
       le16 padding;
       le32 flags;
   };

   /* Device-&gt;driver fields */
   struct virtio_i2c_in_hdr
   {
       le16 written;
       le16 read;
       u8 status;
   };
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
written/read are not device-&gt;driver fields. They are driver-&gt;device f=
ields.
They are not determined by the device but the driver(user).

However, Michael said that the two fields may duplicate buf size available
in the descriptor. He intended to remove them.

"
I note that read and written actually duplicate buf size
available in the descriptor.
Given we no longer mirror i2c_msg 1:1 do we still want to do this?
It will be trivial for the host device to populate these fields
correctly for linux.
Duplication of information iten leads to errors ...
"

But there is a corner case I'm not sure if you have noticed.

read and written can be 0. I think we may not put a buf with size 0 into th=
e
virtqueue.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
You always have the header and the status, right?
E.g. with the below, the total buffer size is virtio_i2c_out_hdr size +
write size for writes and read size + virtio_i2c_in_hdr size for reads.
Neither result is ever 0.
</pre>
    </blockquote>
    <p>Then how to distinguish the request type the buffer contains.<br>
    </p>
    <p>Each type will have both virtio_i2c_out_hdr and <span
        class=3D"fontstyle0">virtio_i2c_in_hdr.</span><br>
      <span class=3D"fontstyle0">the backend can know the type by checking
        the read/written.</span></p>
    <span class=3D"fontstyle0">If the </span><span class=3D"fontstyle2">rea=
d</span><span
      class=3D"fontstyle0">=3D0 and the </span><span class=3D"fontstyle2">w=
ritten</span><span
      class=3D"fontstyle0">&gt;0, the request is a write request</span><br>
    <span class=3D"fontstyle0">The buffer may contains 3 scatterlist:</span=
>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 </span>virtio_i2c_out_=
hdr //
      scatterlist[0]</p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 buf[/* this is write d=
ata, since
        read =3D 0 */]=C2=A0 </span>// scatterlist[1]</p>
    <p><span class=3D"fontstyle0"></span></p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr=C2=
=A0=C2=A0 </span><span
        class=3D"fontstyle0">// scatterlist[2]</span></p>
    <p><span class=3D"fontstyle0"></span><span class=3D"fontstyle0">If the =
</span><span
        class=3D"fontstyle2">read</span><span class=3D"fontstyle0">&gt;0 an=
d
        the </span><span class=3D"fontstyle2">written</span><span
        class=3D"fontstyle0">=3D0, the request is a read request.</span><br=
>
      <span class=3D"fontstyle0"><span class=3D"fontstyle0">The buffer may
          contains </span></span><span class=3D"fontstyle0"><span
          class=3D"fontstyle0"><span class=3D"fontstyle0">3 scatterlist</sp=
an>:</span></span></p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 </span>virtio_i2c_out_=
hdr //
      scatterlist[0]</p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 buf[/* This is read da=
ta, since
        written =3D 0 */] </span>// scatterlist[1]</p>
    <p><span class=3D"fontstyle0"></span></p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr=C2=
=A0 </span><span
        class=3D"fontstyle0"><span class=3D"fontstyle0">// scatterlist[2]</=
span></span></p>
    <p><span class=3D"fontstyle0"><span class=3D"fontstyle0"></span></span>=
</p>
    <p><span class=3D"fontstyle0">If the </span><span class=3D"fontstyle2">=
read</span><span
        class=3D"fontstyle0">&gt;0 and the </span><span
        class=3D"fontstyle2">written</span><span class=3D"fontstyle0">&gt;0=
,
        the request is a write-read request.</span><br>
      <span class=3D"fontstyle0"><span class=3D"fontstyle0"><span
            class=3D"fontstyle0">The buffer may contains 4 </span></span></=
span><span
        class=3D"fontstyle0"><span class=3D"fontstyle0"><span
            class=3D"fontstyle0"><span class=3D"fontstyle0">scatterlist</sp=
an>:</span></span></span></p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 </span>virtio_i2c_out_=
hdr=C2=A0=C2=A0 //
      scatterlist[0]</p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 buf[/*write data*/]=C2=
=A0 // </span><span
        class=3D"fontstyle0">scatterlist[1]</span></p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 buf[/*read data*/]=C2=
=A0 </span><span
        class=3D"fontstyle0"><span class=3D"fontstyle0">// </span><span
          class=3D"fontstyle0">scatterlist[2]</span> </span></p>
    <p><span class=3D"fontstyle0"></span></p>
    <p><span class=3D"fontstyle0">=C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr=C2=
=A0=C2=A0=C2=A0=C2=A0 </span><span
        class=3D"fontstyle0"><span class=3D"fontstyle0"><span
            class=3D"fontstyle0">// </span><span class=3D"fontstyle0">scatt=
erlist[3]</span>
        </span></span></p>
    <p><span class=3D"fontstyle0"></span> </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201218155526-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">@Stefan @Paolo

So what's your opinion about these two fields ?

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">   /*
    * Virtqueue element layout looks like this:
    *
    * struct virtio_i2c_out_hdr out_hdr; /* OUT */
    * u8 write_buf[]; /* OUT */
    * u8 read_buf[]; /* IN */
    * struct virtio_i2c_in_hdr in_hdr; /* IN */
    */

This makes sense to me: a bi-directional request has both write_buf[]
and read_buf[] so the vring used.len field is not enough to report back
how many bytes were written and read. The virtio_i2c_in_hdr fields are
really needed.

Please split the struct in the spec so it's clear how this works.
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------38126D33142EC29995F94C76--

