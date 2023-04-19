Return-Path: <virtio-dev-return-12314-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD639C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:50:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03F052B014
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:50:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7962986615
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:50:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 95999986422; Wed, 19 Apr 2023 13:50:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 377A1986426
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 13:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681912184; x=1684504184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01sxgQIxencg5TtolijUItyYJDdAvlMGoTyAZwSYRGo=;
        b=gVbsDSpVgyHjmG4mTYt2ILTDNIjmvCP6IYem+vKaEasp/ZZYDhPN4zlLqd7KG7DSo0
         MZLPV6NgJJVyBGLph1V6Uw0kAup+PnWR+u6q4MFpKCPa7EGkBt0XVKMaSwV0THfsmovg
         9BG2X1buJ787kA73bMoRGmpNDwAkyFPgh9IIn8JZZbH9v8uw+raqthAaNRgTGluMxDRI
         UpG6QYL9+LP+tgp0t6A9q8bVT2xAukFhqvEmEOWUvrIacuujE3RLHhCeOXiPrpIb3Zag
         RfPqV/VbTSGkBs/vN3qM1XbNv7/C0v3LUn/jfnMgUFl4iMmiHi2cBrqs8fkaw/+kTlXV
         nnYQ==
X-Gm-Message-State: AAQBX9c2M0AgOZ8NrPrxmcSH+T8UenqzucwLteaGUZUpjt/T4lzH1Xaa
	QNi0UmwYZuRZmUNdlSlNO+oYnIeOHbMhJEd164GKaA==
X-Google-Smtp-Source: AKy350Y0pPy403PqcVBw9E94eiiPJIZC0ciKbz4amYqGVS09kN6azZWYMxIrKpqyK0cXJDw4TL6aAXTiQzSeiu+2+RI=
X-Received: by 2002:a17:906:5410:b0:94a:5ecb:6ea7 with SMTP id
 q16-20020a170906541000b0094a5ecb6ea7mr14765712ejo.43.1681912184522; Wed, 19
 Apr 2023 06:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANN35wLsm_RTTKmxFz5jcBujoxfjPwsu37FAw9+W58hjt_nVPQ@mail.gmail.com>
 <1681804788.7404423-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681804788.7404423-1-xuanzhuo@linux.alibaba.com>
From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
Date: Wed, 19 Apr 2023 16:49:33 +0300
Message-ID: <CANN35wKBSJ-cxju6oM1E0B70Hm-Rs2Z2Q+SybOgFMkp4oeJ36A@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Daniel Raho <s.raho@virtualopensystems.com>, 
	Michele Paolino <m.paolino@virtualopensystems.com>, 
	Alvise Rigo <a.rigo@virtualopensystems.com>, chou.kensou@jp.panasonic.com, 
	wminer@linuxfoundation.org, stefanha@redhat.com, 
	virtio-dev@lists.oasis-open.org, 
	linwen deng <linwendeng@virtualopensystems.com>
Content-Type: multipart/alternative; boundary="0000000000004d5c4205f9b0b2cf"
Subject: Re: [virtio-dev] Virtio-loopback: PoC of a new Hardware Abstraction
 Layer for non-Hypervisor environments based on Virtio

--0000000000004d5c4205f9b0b2cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Xuan,

The main differences between virtio-loopback and vDUSE are mainly:

1) the data sharing mechanism

2) the Virtio/Vhost-user devices which are supported by each solution


In particular, Virtio-loopback implements a zero-copy memory mapping

mechanism, the data are directly accessible by the user-space and

supports vhost-user-blk, vhost-user-input, vhost-user-rng.


At the best of my knowledge, VDUSE is based on a bouncing buffer

mechanism which does not implement the zero-copy principle. In addition,

it supports vhost-user-blk and vhost-user-net only.

Kind regards,

Timos


On Tue, Apr 18, 2023 at 11:01=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com>
wrote:

> On Thu, 13 Apr 2023 16:35:59 +0300, Timos Ampelikiotis <
> t.ampelikiotis@virtualopensystems.com> wrote:
> > Dear virtio-dev community,
> >
> > I would like to introduce you Virtio-loopback, Proof of Concept (PoC)
> that
> > we have been working on at Virtual Open Systems in the context of the
> > Automotive Grade Linux community (Virtualization & Containers expert
> > group - EG-VIRT).
> >
> > We consider this work as a PoC and we are not currently planning
> > upstream. However, if the zero-copy or any other aspect of this work
> > is interesting for other Virtio implementations, we would be glad to
> > discuss more.
>
> What is the difference between this and vduse?
>
> Thanks.
>
> >
> > Overview:
> > ---------
> >
> > Virtio-loopback is a new hardware abstraction layer designed for
> > non-Hypervisor
> > environments based on virtio. The main objective is to enable
> applications
> > communication with vhost-user devices in a non-hypervisor environment.
> >
> > More in details, Virtio-loopback's design consists of a new transport
> > (Virtio-loopback), a user-space daemon (Adapter), and a vhost-user
> device.
> > The data path has been implemented using the "zero-copy" principle, whe=
re
> > vhost-user devices access virtqueues directly in the kernel space. This
> > first
> > implementation supports multi-queues, does not require virtio-protocol
> > changes
> > and applies minor modifications to the vhost-user library. Supported
> > vhost-user
> > devices are today vhost-user-rng (both rust and C version),
> vhost-user-input
> > and vhost-user-blk.
> >
> > Motivation & requirements:
> > -------------------------
> >
> > 1. Enable the usage of the same user-space driver on both virtualized a=
nd
> >    non-virtualized environments.
> >
> > 2. Maximize performance with zero copy design principles
> >
> > 3. Applications using such drivers are unchanged and transparently
> running
> > in
> >    both virtualized or non-virtualized environment.
> >
> > Design description:
> > -------------------
> >
> > a) Component's description:
> > --------------------------
> >
> > The Virtio-loopback architecture consists of three main components
> > described below:
> >
> > 1) Driver: In order to route the VIRTIO communication in user-space
> >    virtio-loopback driver was implemented and consists of:
> >    - A new transport layer which is based on virtio-mmio and it is
> >      responsible of routing the read/write communication of the virtio
> >      device to the adapter binary.
> >    - A character device which works as an intermediate layer between th=
e
> >      user-space components and the transport layer. The character devic=
e
> > helps
> >      the adapter to provide all the required information and initialize
> the
> >      transport and at the same time, provides direct access to the vrin=
gs
> >      from user-space. The access to the vrings is based on a memory
> mapping
> >      mechanism which gives the ability to the vhost-user device to read
> and
> >      write data directly into kernel's memory without the need of any
> copy.
> >
> > 2) Adapter: Implements the role that QEMU had in the corresponding
> > virtualized
> >    scenario. Specifically, combines the functionality of two main QEMU
> >    components, virtio-mmio transport emulation and vhost-user backend, =
in
> > order
> >    to work as a bridge between the transport and the vhost-user device.
> The
> > two
> >    main parts of the adapter are:
> >    - A vhost-user backend which is the main communication point with th=
e
> >      vhost-user device.
> >    - A virtio-emulation which handles mostly the messages coming from t=
he
> >      driver and translates them into vhost-user messages/actions.
> >
> > 3) Vhost-user device: This components required only minimal
> modifications to
> >    make the vrings directly accessible in kernel's memory.
> >
> > b) Communication between the virtio-loopback components:
> > -------------------------------------------------------
> >
> > After the describing the role of its component, a few details need to b=
e
> > given
> > about how they interact with each other and the mechanisms used.
> >
> > 1) Transport & Adapter:
> >    - The two components share a communication data structure which
> describes
> >      the current read/write operation requested by the transport.
> >    - When this data structure has been filled with all the required
> > information
> >      the transport triggers and EventFD and waits. The adapter wakes up=
,
> > takes
> >      the corresponding actions and finally notifies and unlocks the
> > transport
> >      by calling an IOCTL system call.
> >    - Compared to the virtualized environment scenario, the adapter call=
s
> an
> >      IOCTL system call to the driver in place of an interrupt.
> >
> > 2) Adapter & Vhost-user device:
> >    - The mechanisms used between these two component are the same as in
> >      the virtualized environment case.
> >      a) A UNIX socket is in place to exchange any VHOST-USER messages.
> >      b) EventFDs are being used in order to trigger VIRTIO kick/call
> >         requests.
> >
> > 3) Transport & Vhost-user device:
> >    - Since the Vrings are allocated into the Kernel's memory, vhost-use=
r
> >      device needs to communicate and request access from the
> virtio-loopback
> >      driver. These requirement is served by implementing MMAP and IOCTL
> > system
> >      calls in the driver.
> >
> > c) Vrings & Zero copy memory mapping mechanism:
> > ----------------------------------------------
> >
> > The vrings are allocated by the virtio driver into the kernel's memory
> space
> > and in order to be accessible by the user-space, especially by the
> > vhost-user
> > device, a new memory mapping mechanism needed to be created into the
> > virtio-loopback driver. The new memory mapping mechanism is based on a
> > page-fault handler which maps the accessed pages on-demand.
> >
> > Known issues & room for improvement:
> > -----------------------------------
> >
> > Known limitation found in the current implementation:
> > - The memory mapping mechanism needs improvements, in the current
> >   implementation the device can potentially access the whole kernel's
> >   memory. A more fine grained mmapping can be set by the kernel by
> >   narrowing down the memory block shared.
> >
> > Possible next development targets might be about:
> > - Security checks for the memory shared with the user-space (vhost
> > user-device)
> > - Add parallel device handling for the virtio-loopback transport and
> adapter
> > - Add support for more vhost-user devices
> >
> > More information:
> > ----------------
> >
> > The full description of the technology can be found in the links below:
> > - Virtio-loopback design document
> > <
> https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loo=
pback-rfc/design_docs/EG-VIRT_VOSYS_virtio_loopback_design_v1.4_2023_04_03.=
pdf
> >
> > - How to test the technology
> > <
> https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loo=
pback-rfc/README.md
> >
> >
> > Links for all the key components of the design can be found below:
> > 1) Virtio-loopback-transport
> > <
> https://git.virtualopensystems.com/virtio-loopback/loopback_driver/-/tree=
/virtio-loopback-rfc
> >
> > 2) Adapter
> > <
> https://git.virtualopensystems.com/virtio-loopback/adapter_app/-/tree/vir=
tio-loopback-rfc
> >
> > 3) Vhost-user devices in Qemu
> > <
> https://git.virtualopensystems.com/virtio-loopback/qemu/-/tree/virtio-loo=
pback-rfc
> >
> >
> > Virtio-loopback has been tested on RCAR-M3 board (AGL needlefish) and x=
86
> > systems (Fedora 37). The results have been found to be comparable with
> VDUSE
> > technology in virtio-blk case:
> > - Automotive Grade Linux All Member Meeting Spring (8-9/03/2023) -
> > Presentation
> > <
> https://static.sched.com/hosted_files/aglammspring2023/44/vosys_virtio-lo=
opback-berlin_2023-03-08.pdf
> >
> >   + Activity done in the context of the AERO EU project (grant agreemen=
t
> No
> > 101092850)
> >
> > Thank you for taking the time to review this PoC,
> > I would appreciate your feedback and suggestions for improvements.
> >
> > Best regards,
> > Timos Ampelikiotis
> >
>

--0000000000004d5c4205f9b0b2cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-efebe2a7-7fff-a012-e3=
38-ad19dfee3373"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;color:rgb(0,0,0);background-=
color:transparent;font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-variant-alternates:normal;vertical-align:baseline;white-space:pre-wr=
ap"><font face=3D"arial, sans-serif">Hello Xuan,</font></span></p><font fac=
e=3D"arial, sans-serif"><br></font><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;color:rgb(=
0,0,0);background-color:transparent;font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline;=
white-space:pre-wrap"><font face=3D"arial, sans-serif">The main differences=
 between virtio-loopback and vDUSE are mainly:</font></span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;color:rgb(0,0,0);background-color:transparent;font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:no=
rmal;vertical-align:baseline;white-space:pre-wrap"><font face=3D"arial, san=
s-serif">1) the data sharing mechanism</font></span></p><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font=
-size:11pt;color:rgb(0,0,0);background-color:transparent;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ver=
tical-align:baseline;white-space:pre-wrap"><font face=3D"arial, sans-serif"=
>2) the Virtio/Vhost-user devices which are supported by each solution</fon=
t></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"font-size:11pt;color:rgb(0,0,0);background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fo=
nt-variant-alternates:normal;vertical-align:baseline;white-space:pre-wrap">=
<font face=3D"arial, sans-serif"><br></font></span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;vert=
ical-align:baseline;white-space:pre-wrap"><font face=3D"arial, sans-serif">=
In particular, Virtio-loopback implements a zero-copy memory mapping</font>=
</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;color:rgb(0,0,0);background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline;white-space:pre-wrap"><f=
ont face=3D"arial, sans-serif">mechanism, the data are directly accessible =
by the user-space and</font></span></p><p dir=3D"ltr" style=3D"line-height:=
1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;color:=
rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-va=
riant-east-asian:normal;font-variant-alternates:normal;vertical-align:basel=
ine;white-space:pre-wrap"><font face=3D"arial, sans-serif">supports vhost-u=
ser-blk, vhost-user-input, vhost-user-rng.</font></span></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:11pt;color:rgb(0,0,0);background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;vertical-align:baseline;white-space:pre-wrap"><font face=3D"arial, sans-se=
rif"><br></font></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;color:rgb(0,0,0);b=
ackground-color:transparent;font-variant-numeric:normal;font-variant-east-a=
sian:normal;font-variant-alternates:normal;vertical-align:baseline;white-sp=
ace:pre-wrap"><font face=3D"arial, sans-serif">At the best of my knowledge,=
 VDUSE is based on a bouncing buffer</font></span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;vert=
ical-align:baseline;white-space:pre-wrap"><font face=3D"arial, sans-serif">=
mechanism which does not implement the zero-copy principle. In addition,</f=
ont></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;color:rgb(0,0,0);background-co=
lor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-variant-alternates:normal;vertical-align:baseline;white-space:pre-wrap=
"><font face=3D"arial, sans-serif">it supports vhost-user-blk and vhost-use=
r-net only.</font></span></p><font face=3D"arial, sans-serif"><br></font><p=
 dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><s=
pan style=3D"font-size:11pt;color:rgb(0,0,0);background-color:transparent;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alte=
rnates:normal;vertical-align:baseline;white-space:pre-wrap"><font face=3D"a=
rial, sans-serif">Kind regards,</font></span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-a=
lign:baseline;white-space:pre-wrap"><font face=3D"arial, sans-serif">Timos<=
/font></span></p></span><br class=3D"gmail-Apple-interchange-newline"></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Apr 18, 2023 at 11:01=E2=80=AFAM Xuan Zhuo &lt;<a href=3D"mailto:xuanzhu=
o@linux.alibaba.com">xuanzhuo@linux.alibaba.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 13 Apr 2023 16:35:59=
 +0300, Timos Ampelikiotis &lt;<a href=3D"mailto:t.ampelikiotis@virtualopen=
systems.com" target=3D"_blank">t.ampelikiotis@virtualopensystems.com</a>&gt=
; wrote:<br>
&gt; Dear virtio-dev community,<br>
&gt;<br>
&gt; I would like to introduce you Virtio-loopback, Proof of Concept (PoC) =
that<br>
&gt; we have been working on at Virtual Open Systems in the context of the<=
br>
&gt; Automotive Grade Linux community (Virtualization &amp; Containers expe=
rt<br>
&gt; group - EG-VIRT).<br>
&gt;<br>
&gt; We consider this work as a PoC and we are not currently planning<br>
&gt; upstream. However, if the zero-copy or any other aspect of this work<b=
r>
&gt; is interesting for other Virtio implementations, we would be glad to<b=
r>
&gt; discuss more.<br>
<br>
What is the difference between this and vduse?<br>
<br>
Thanks.<br>
<br>
&gt;<br>
&gt; Overview:<br>
&gt; ---------<br>
&gt;<br>
&gt; Virtio-loopback is a new hardware abstraction layer designed for<br>
&gt; non-Hypervisor<br>
&gt; environments based on virtio. The main objective is to enable applicat=
ions<br>
&gt; communication with vhost-user devices in a non-hypervisor environment.=
<br>
&gt;<br>
&gt; More in details, Virtio-loopback&#39;s design consists of a new transp=
ort<br>
&gt; (Virtio-loopback), a user-space daemon (Adapter), and a vhost-user dev=
ice.<br>
&gt; The data path has been implemented using the &quot;zero-copy&quot; pri=
nciple, where<br>
&gt; vhost-user devices access virtqueues directly in the kernel space. Thi=
s<br>
&gt; first<br>
&gt; implementation supports multi-queues, does not require virtio-protocol=
<br>
&gt; changes<br>
&gt; and applies minor modifications to the vhost-user library. Supported<b=
r>
&gt; vhost-user<br>
&gt; devices are today vhost-user-rng (both rust and C version), vhost-user=
-input<br>
&gt; and vhost-user-blk.<br>
&gt;<br>
&gt; Motivation &amp; requirements:<br>
&gt; -------------------------<br>
&gt;<br>
&gt; 1. Enable the usage of the same user-space driver on both virtualized =
and<br>
&gt;=C2=A0 =C2=A0 non-virtualized environments.<br>
&gt;<br>
&gt; 2. Maximize performance with zero copy design principles<br>
&gt;<br>
&gt; 3. Applications using such drivers are unchanged and transparently run=
ning<br>
&gt; in<br>
&gt;=C2=A0 =C2=A0 both virtualized or non-virtualized environment.<br>
&gt;<br>
&gt; Design description:<br>
&gt; -------------------<br>
&gt;<br>
&gt; a) Component&#39;s description:<br>
&gt; --------------------------<br>
&gt;<br>
&gt; The Virtio-loopback architecture consists of three main components<br>
&gt; described below:<br>
&gt;<br>
&gt; 1) Driver: In order to route the VIRTIO communication in user-space<br=
>
&gt;=C2=A0 =C2=A0 virtio-loopback driver was implemented and consists of:<b=
r>
&gt;=C2=A0 =C2=A0 - A new transport layer which is based on virtio-mmio and=
 it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 responsible of routing the read/write communicatio=
n of the virtio<br>
&gt;=C2=A0 =C2=A0 =C2=A0 device to the adapter binary.<br>
&gt;=C2=A0 =C2=A0 - A character device which works as an intermediate layer=
 between the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 user-space components and the transport layer. The=
 character device<br>
&gt; helps<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the adapter to provide all the required informatio=
n and initialize the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 transport and at the same time, provides direct ac=
cess to the vrings<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from user-space. The access to the vrings is based=
 on a memory mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mechanism which gives the ability to the vhost-use=
r device to read and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 write data directly into kernel&#39;s memory witho=
ut the need of any copy.<br>
&gt;<br>
&gt; 2) Adapter: Implements the role that QEMU had in the corresponding<br>
&gt; virtualized<br>
&gt;=C2=A0 =C2=A0 scenario. Specifically, combines the functionality of two=
 main QEMU<br>
&gt;=C2=A0 =C2=A0 components, virtio-mmio transport emulation and vhost-use=
r backend, in<br>
&gt; order<br>
&gt;=C2=A0 =C2=A0 to work as a bridge between the transport and the vhost-u=
ser device. The<br>
&gt; two<br>
&gt;=C2=A0 =C2=A0 main parts of the adapter are:<br>
&gt;=C2=A0 =C2=A0 - A vhost-user backend which is the main communication po=
int with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vhost-user device.<br>
&gt;=C2=A0 =C2=A0 - A virtio-emulation which handles mostly the messages co=
ming from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 driver and translates them into vhost-user message=
s/actions.<br>
&gt;<br>
&gt; 3) Vhost-user device: This components required only minimal modificati=
ons to<br>
&gt;=C2=A0 =C2=A0 make the vrings directly accessible in kernel&#39;s memor=
y.<br>
&gt;<br>
&gt; b) Communication between the virtio-loopback components:<br>
&gt; -------------------------------------------------------<br>
&gt;<br>
&gt; After the describing the role of its component, a few details need to =
be<br>
&gt; given<br>
&gt; about how they interact with each other and the mechanisms used.<br>
&gt;<br>
&gt; 1) Transport &amp; Adapter:<br>
&gt;=C2=A0 =C2=A0 - The two components share a communication data structure=
 which describes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the current read/write operation requested by the =
transport.<br>
&gt;=C2=A0 =C2=A0 - When this data structure has been filled with all the r=
equired<br>
&gt; information<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the transport triggers and EventFD and waits. The =
adapter wakes up,<br>
&gt; takes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the corresponding actions and finally notifies and=
 unlocks the<br>
&gt; transport<br>
&gt;=C2=A0 =C2=A0 =C2=A0 by calling an IOCTL system call.<br>
&gt;=C2=A0 =C2=A0 - Compared to the virtualized environment scenario, the a=
dapter calls an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 IOCTL system call to the driver in place of an int=
errupt.<br>
&gt;<br>
&gt; 2) Adapter &amp; Vhost-user device:<br>
&gt;=C2=A0 =C2=A0 - The mechanisms used between these two component are the=
 same as in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the virtualized environment case.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a) A UNIX socket is in place to exchange any VHOST=
-USER messages.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 b) EventFDs are being used in order to trigger VIR=
TIO kick/call<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0requests.<br>
&gt;<br>
&gt; 3) Transport &amp; Vhost-user device:<br>
&gt;=C2=A0 =C2=A0 - Since the Vrings are allocated into the Kernel&#39;s me=
mory, vhost-user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 device needs to communicate and request access fro=
m the virtio-loopback<br>
&gt;=C2=A0 =C2=A0 =C2=A0 driver. These requirement is served by implementin=
g MMAP and IOCTL<br>
&gt; system<br>
&gt;=C2=A0 =C2=A0 =C2=A0 calls in the driver.<br>
&gt;<br>
&gt; c) Vrings &amp; Zero copy memory mapping mechanism:<br>
&gt; ----------------------------------------------<br>
&gt;<br>
&gt; The vrings are allocated by the virtio driver into the kernel&#39;s me=
mory space<br>
&gt; and in order to be accessible by the user-space, especially by the<br>
&gt; vhost-user<br>
&gt; device, a new memory mapping mechanism needed to be created into the<b=
r>
&gt; virtio-loopback driver. The new memory mapping mechanism is based on a=
<br>
&gt; page-fault handler which maps the accessed pages on-demand.<br>
&gt;<br>
&gt; Known issues &amp; room for improvement:<br>
&gt; -----------------------------------<br>
&gt;<br>
&gt; Known limitation found in the current implementation:<br>
&gt; - The memory mapping mechanism needs improvements, in the current<br>
&gt;=C2=A0 =C2=A0implementation the device can potentially access the whole=
 kernel&#39;s<br>
&gt;=C2=A0 =C2=A0memory. A more fine grained mmapping can be set by the ker=
nel by<br>
&gt;=C2=A0 =C2=A0narrowing down the memory block shared.<br>
&gt;<br>
&gt; Possible next development targets might be about:<br>
&gt; - Security checks for the memory shared with the user-space (vhost<br>
&gt; user-device)<br>
&gt; - Add parallel device handling for the virtio-loopback transport and a=
dapter<br>
&gt; - Add support for more vhost-user devices<br>
&gt;<br>
&gt; More information:<br>
&gt; ----------------<br>
&gt;<br>
&gt; The full description of the technology can be found in the links below=
:<br>
&gt; - Virtio-loopback design document<br>
&gt; &lt;<a href=3D"https://git.virtualopensystems.com/virtio-loopback/docs=
/-/blob/virtio-loopback-rfc/design_docs/EG-VIRT_VOSYS_virtio_loopback_desig=
n_v1.4_2023_04_03.pdf" rel=3D"noreferrer" target=3D"_blank">https://git.vir=
tualopensystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/design_=
docs/EG-VIRT_VOSYS_virtio_loopback_design_v1.4_2023_04_03.pdf</a>&gt;<br>
&gt; - How to test the technology<br>
&gt; &lt;<a href=3D"https://git.virtualopensystems.com/virtio-loopback/docs=
/-/blob/virtio-loopback-rfc/README.md" rel=3D"noreferrer" target=3D"_blank"=
>https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loop=
back-rfc/README.md</a>&gt;<br>
&gt;<br>
&gt; Links for all the key components of the design can be found below:<br>
&gt; 1) Virtio-loopback-transport<br>
&gt; &lt;<a href=3D"https://git.virtualopensystems.com/virtio-loopback/loop=
back_driver/-/tree/virtio-loopback-rfc" rel=3D"noreferrer" target=3D"_blank=
">https://git.virtualopensystems.com/virtio-loopback/loopback_driver/-/tree=
/virtio-loopback-rfc</a>&gt;<br>
&gt; 2) Adapter<br>
&gt; &lt;<a href=3D"https://git.virtualopensystems.com/virtio-loopback/adap=
ter_app/-/tree/virtio-loopback-rfc" rel=3D"noreferrer" target=3D"_blank">ht=
tps://git.virtualopensystems.com/virtio-loopback/adapter_app/-/tree/virtio-=
loopback-rfc</a>&gt;<br>
&gt; 3) Vhost-user devices in Qemu<br>
&gt; &lt;<a href=3D"https://git.virtualopensystems.com/virtio-loopback/qemu=
/-/tree/virtio-loopback-rfc" rel=3D"noreferrer" target=3D"_blank">https://g=
it.virtualopensystems.com/virtio-loopback/qemu/-/tree/virtio-loopback-rfc</=
a>&gt;<br>
&gt;<br>
&gt; Virtio-loopback has been tested on RCAR-M3 board (AGL needlefish) and =
x86<br>
&gt; systems (Fedora 37). The results have been found to be comparable with=
 VDUSE<br>
&gt; technology in virtio-blk case:<br>
&gt; - Automotive Grade Linux All Member Meeting Spring (8-9/03/2023) -<br>
&gt; Presentation<br>
&gt; &lt;<a href=3D"https://static.sched.com/hosted_files/aglammspring2023/=
44/vosys_virtio-loopback-berlin_2023-03-08.pdf" rel=3D"noreferrer" target=
=3D"_blank">https://static.sched.com/hosted_files/aglammspring2023/44/vosys=
_virtio-loopback-berlin_2023-03-08.pdf</a>&gt;<br>
&gt;=C2=A0 =C2=A0+ Activity done in the context of the AERO EU project (gra=
nt agreement No<br>
&gt; 101092850)<br>
&gt;<br>
&gt; Thank you for taking the time to review this PoC,<br>
&gt; I would appreciate your feedback and suggestions for improvements.<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Timos Ampelikiotis<br>
&gt;<br>
</blockquote></div>

--0000000000004d5c4205f9b0b2cf--
