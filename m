Return-Path: virtio-dev-return-7465-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98198986107
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jun 2020 11:33:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Date: Thu, 11 Jun 2020 13:33:04 +0200
Message-Id: <613382D2-5F4D-4A32-AC8E-E1D03240036F@redhat.com>
References: <20200611071744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200611071744-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Content-Type: multipart/alternative; boundary=Apple-Mail-3BDDA998-C2BD-49D8-8575-72FA81B00AAD
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail-3BDDA998-C2BD-49D8-8575-72FA81B00AAD
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Am 11.06.2020 um 13:18 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Thu, Jun 11, 2020 at 01:00:24PM +0200, David Hildenbrand wrot=
e:
>>>> I'd like to have this patch in 5.8, with the initial merge of virtio-m=
em
>>>> if possible (so the user space representation of virtio-mem added memo=
ry
>>>> resources won't change anymore).
>>>=20
>>> So my plan is to rebase on top of -rc1 and merge this for rc2 then.
>>> I don't like rebase on top of tip as the results are sometimes kind of
>>> random.
>>=20
>> Right, I just wanted to get this out early so we can discuss how to proc=
eed.
>>=20
>>> And let's add a Fixes: tag as well, this way people will remember to
>>> pick this.
>>> Makes sense?
>>=20
>> Yes, it's somehow a fix (for kexec). So
>>=20
>> Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
>>=20
>> I can respin after -rc1 with the commit id fixed as noted by Pankaj.
>> Just let me know what you prefer.
>>=20
>> Thanks!
>=20
> Some once this commit is in Linus' tree, please ping me.

It already is as mentioned, only the id was wrong.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D7b7b27214bba1966772f9213cd2d8e5d67f8487f

>=20
>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20

--Apple-Mail-3BDDA998-C2BD-49D8-8575-72FA81B00AAD
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><div dir=3D"ltr"><br></div><div dir=3D"=
ltr"><br><blockquote type=3D"cite">Am 11.06.2020 um 13:18 schrieb Michael S=
. Tsirkin &lt;mst@redhat.com&gt;:<br><br></blockquote></div><blockquote typ=
e=3D"cite"><div dir=3D"ltr">=EF=BB=BF<span>On Thu, Jun 11, 2020 at 01:00:24=
PM +0200, David Hildenbrand wrote:</span><br><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>I'd like to have this=
 patch in 5.8, with the initial merge of virtio-mem</span><br></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>if possible (so the user space represent=
ation of virtio-mem added memory</span><br></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>resources won't change anymore).</span><br></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span></span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>So my plan is to rebase on top of -rc1 and merge =
this for rc2 then.</span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>I don't like rebase on top of tip as =
the results are sometimes kind of</span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>random.</span><br></bl=
ockquote></blockquote><blockquote type=3D"cite"><span></span><br></blockquo=
te><blockquote type=3D"cite"><span>Right, I just wanted to get this out ear=
ly so we can discuss how to proceed.</span><br></blockquote><blockquote typ=
e=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>And let's add a Fixes: tag as well, this way people=
 will remember to</span><br></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>pick this.</span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Makes se=
nse?</span><br></blockquote></blockquote><blockquote type=3D"cite"><span></=
span><br></blockquote><blockquote type=3D"cite"><span>Yes, it's somehow a f=
ix (for kexec). So</span><br></blockquote><blockquote type=3D"cite"><span><=
/span><br></blockquote><blockquote type=3D"cite"><span>Fixes: 5f1f79bbc9e26=
 ("virtio-mem: Paravirtualized memory hotplug")</span><br></blockquote><blo=
ckquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cit=
e"><span>I can respin after -rc1 with the commit id fixed as noted by Panka=
j.</span><br></blockquote><blockquote type=3D"cite"><span>Just let me know =
what you prefer.</span><br></blockquote><blockquote type=3D"cite"><span></s=
pan><br></blockquote><blockquote type=3D"cite"><span>Thanks!</span><br></bl=
ockquote><span></span><br><span>Some once this commit is in Linus' tree, pl=
ease ping me.</span><br></div></blockquote><div><br></div><div>It already i=
s as mentioned, only the id was wrong.</div><div><br></div><div><a href=3D"=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D7b7b27214bba1966772f9213cd2d8e5d67f8487f">https://git.kernel.org/pub/=
scm/linux/kernel/git/next/linux-next.git/commit/?id=3D7b7b27214bba1966772f9=
213cd2d8e5d67f8487f</a></div><br><blockquote type=3D"cite"><div dir=3D"ltr"=
><span></span><br><blockquote type=3D"cite"><span>-- </span><br></blockquot=
e><blockquote type=3D"cite"><span>Thanks,</span><br></blockquote><blockquot=
e type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><sp=
an>David / dhildenb</span><br></blockquote><span></span><br></div></blockqu=
ote></body></html>
--Apple-Mail-3BDDA998-C2BD-49D8-8575-72FA81B00AAD--

