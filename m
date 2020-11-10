Return-Path: virtio-comment-return-1502-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <61930337391bdfd23ed164288d998c04177bc839.1603435652.git.jie.deng@intel.com>
 <20201023115932-mutt-send-email-mst@kernel.org> <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
 <20201027071957-mutt-send-email-mst@kernel.org> <d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com>
 <a7c27a1d-eca7-f0a6-0bcc-4fdbb9d7a001@intel.com>
In-Reply-To: <a7c27a1d-eca7-f0a6-0bcc-4fdbb9d7a001@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Nov 2020 08:51:22 +0100
Message-ID: <CABgObfaMG8y-_yv+-f3Qsf=i17VCgxABaveHo7bq6vHPDPtd2g@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v2] virtio-i2c: add the device specification
Content-Type: multipart/alternative; boundary="00000000000093302205b3bbf2c2"
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, stefanha@redhat.com, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000093302205b3bbf2c2
Content-Type: text/plain; charset="UTF-8"

It'd always be a write followed by a read. Usually the write provides the
number of a register to be read.

The opposite order does not make much sense.

Paolo

Il gio 5 nov 2020, 07:35 Jie Deng <jie.deng@intel.com> ha scritto:

>
> On 2020/10/31 21:58, Paolo Bonzini wrote:
>
> On 27/10/20 12:20, Michael S. Tsirkin wrote:
>
> The I2C doesn't support segments numbering and sorting.
> So if one creates a multi-segment transaction, then he/she should keep the
> segments in order.
>
> Thanks.
>
> Fine, but I see no flags to signal start/end of such a transaction.
>
>
>
> In theory there's no difference between one multi-segment transaction
> and many single-segment transactions _in a single-master scenario_.
>
> However, it is a plausible configuration to have multiple guests sharing
> an I2C host device as if they were multiple master.
>
> For this reason, I would prefer to have at least support for
> transactions with 1 write and 1 read segment to the same address (see my
> other message).
>
> Paolo
>
> Then how to distinguish the order of the two segments if they are in one
> request ?
> We don't know this is a write followed by a read or a read followed by a
> write in this case.
>
> However, if the request is the representation of only one segment of an
> I2C transaction,
> we can simply judge by the order of the requests in the virtqueue.
>
> Thanks
>
>

--00000000000093302205b3bbf2c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It&#39;d always be a write followed by a read. Usually th=
e write provides the number of a register to be read.<div dir=3D"auto"><br>=
</div><div dir=3D"auto">The opposite order does not make much sense.<div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 5 nov 2020, =
07:35 Jie Deng &lt;<a href=3D"mailto:jie.deng@intel.com">jie.deng@intel.com=
</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 2020/10/31 21:58, Paolo Bonzini
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>On 27/10/20 12:20, Michael S. Tsirkin wrote:
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre>The I2C doesn&#39;t support segments numbering and sorting.
So if one creates a multi-segment transaction, then he/she should keep the
segments in order.

Thanks.
</pre>
        </blockquote>
        <pre>Fine, but I see no flags to signal start/end of such a transac=
tion.

</pre>
      </blockquote>
      <pre>
In theory there&#39;s no difference between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.

For this reason, I would prefer to have at least support for
transactions with 1 write and 1 read segment to the same address (see my
other message).

Paolo
</pre>
    </blockquote>
    Then how to distinguish the order of the two segments if they are in
    one request ?<br>
    We don&#39;t know this is a write followed by a read or a read followed
    by a write in this case.<br>
    <span></span><br>
    <span>However, if the request is the
      representation of only one segment of an I2C transaction,</span><br>
    <span>we can simply judge by the order of the
      requests in the virtqueue.</span>
    <p><span>Thanks<br>
      </span></p>
    <p><span></span></p>
    <blockquote type=3D"cite">
      <pre>
</pre>
    </blockquote>
  </div>

</blockquote></div>

--00000000000093302205b3bbf2c2--

