Return-Path: <virtio-dev-return-12207-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE80C77B6E
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 13:36:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BAFA52B146
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 13:36:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9661B986601
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 13:36:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7E425986360; Thu, 13 Apr 2023 13:36:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B5A29865F8
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 13:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392971; x=1683984971;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMGVWvpILtpdco9LjLsF4pzd8Gy5M98Wxi0qcDjc2PI=;
        b=OYxUE5B0yF1vCYVdBUqSyHk1sLD51nPJtOx1BTxflkM6qOFrSbCR5NNwzQ1VJukS0H
         EHD6mxdjr2Sn+6SzEYKbQ8vqdnj8yBWciodGTpbOaf9BKHjQOz2rpqo97YQNHMxrkUFA
         Z5ehiyAMZOGScTZ7bwooZ3xrqqL9tbV8GRHBOdr4ESRJKGKsWaaw5G7t5JA2taYdSCdr
         nvl20qWNV7Shf9Mwr1/Z9vUFfnkxtUQ3Fbfn9/J3zEpGoFU7zs8uVAxPHaJ9RkfnkMZQ
         bnbWyaiaSO3FOfUUkG77a43qMiNHhI3fa++qFi1e5nUKW89J9yLNbC3jtkuUW/IkgmN0
         OyQg==
X-Gm-Message-State: AAQBX9cZkmFxtcV3yuEZMsaPYeSv9nY653DKXjyduwxDIbRo2kERYj8Z
	RYhN6DwNyL++cae8BNjsyGRf5qLJLNMZrufbuySKuV+C0Kg4lKivDUatnGgA
X-Google-Smtp-Source: AKy350Y0cVV26MJTqqGrMdHB1FM2YJOSgG+Sxtzre1BoBdHOmiU249uBqmrEenVgC4ovMqQp0djA4/DSeAj32Zzp2O0=
X-Received: by 2002:a17:906:d298:b0:932:1bdf:be3e with SMTP id
 ay24-20020a170906d29800b009321bdfbe3emr1318150ejb.0.1681392970881; Thu, 13
 Apr 2023 06:36:10 -0700 (PDT)
MIME-Version: 1.0
From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
Date: Thu, 13 Apr 2023 16:35:59 +0300
Message-ID: <CANN35wLsm_RTTKmxFz5jcBujoxfjPwsu37FAw9+W58hjt_nVPQ@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org
Cc: Daniel Raho <s.raho@virtualopensystems.com>, 
	Michele Paolino <m.paolino@virtualopensystems.com>, 
	Alvise Rigo <a.rigo@virtualopensystems.com>, chou.kensou@jp.panasonic.com, 
	wminer@linuxfoundation.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c1ee5205f937ce4b"
Subject: [virtio-dev] Virtio-loopback: PoC of a new Hardware Abstraction Layer for
 non-Hypervisor environments based on Virtio

--000000000000c1ee5205f937ce4b
Content-Type: text/plain; charset="UTF-8"

Dear virtio-dev community,

I would like to introduce you Virtio-loopback, Proof of Concept (PoC) that
we have been working on at Virtual Open Systems in the context of the
Automotive Grade Linux community (Virtualization & Containers expert
group - EG-VIRT).

We consider this work as a PoC and we are not currently planning
upstream. However, if the zero-copy or any other aspect of this work
is interesting for other Virtio implementations, we would be glad to
discuss more.

Overview:
---------

Virtio-loopback is a new hardware abstraction layer designed for
non-Hypervisor
environments based on virtio. The main objective is to enable applications
communication with vhost-user devices in a non-hypervisor environment.

More in details, Virtio-loopback's design consists of a new transport
(Virtio-loopback), a user-space daemon (Adapter), and a vhost-user device.
The data path has been implemented using the "zero-copy" principle, where
vhost-user devices access virtqueues directly in the kernel space. This
first
implementation supports multi-queues, does not require virtio-protocol
changes
and applies minor modifications to the vhost-user library. Supported
vhost-user
devices are today vhost-user-rng (both rust and C version), vhost-user-input
and vhost-user-blk.

Motivation & requirements:
-------------------------

1. Enable the usage of the same user-space driver on both virtualized and
   non-virtualized environments.

2. Maximize performance with zero copy design principles

3. Applications using such drivers are unchanged and transparently running
in
   both virtualized or non-virtualized environment.

Design description:
-------------------

a) Component's description:
--------------------------

The Virtio-loopback architecture consists of three main components
described below:

1) Driver: In order to route the VIRTIO communication in user-space
   virtio-loopback driver was implemented and consists of:
   - A new transport layer which is based on virtio-mmio and it is
     responsible of routing the read/write communication of the virtio
     device to the adapter binary.
   - A character device which works as an intermediate layer between the
     user-space components and the transport layer. The character device
helps
     the adapter to provide all the required information and initialize the
     transport and at the same time, provides direct access to the vrings
     from user-space. The access to the vrings is based on a memory mapping
     mechanism which gives the ability to the vhost-user device to read and
     write data directly into kernel's memory without the need of any copy.

2) Adapter: Implements the role that QEMU had in the corresponding
virtualized
   scenario. Specifically, combines the functionality of two main QEMU
   components, virtio-mmio transport emulation and vhost-user backend, in
order
   to work as a bridge between the transport and the vhost-user device. The
two
   main parts of the adapter are:
   - A vhost-user backend which is the main communication point with the
     vhost-user device.
   - A virtio-emulation which handles mostly the messages coming from the
     driver and translates them into vhost-user messages/actions.

3) Vhost-user device: This components required only minimal modifications to
   make the vrings directly accessible in kernel's memory.

b) Communication between the virtio-loopback components:
-------------------------------------------------------

After the describing the role of its component, a few details need to be
given
about how they interact with each other and the mechanisms used.

1) Transport & Adapter:
   - The two components share a communication data structure which describes
     the current read/write operation requested by the transport.
   - When this data structure has been filled with all the required
information
     the transport triggers and EventFD and waits. The adapter wakes up,
takes
     the corresponding actions and finally notifies and unlocks the
transport
     by calling an IOCTL system call.
   - Compared to the virtualized environment scenario, the adapter calls an
     IOCTL system call to the driver in place of an interrupt.

2) Adapter & Vhost-user device:
   - The mechanisms used between these two component are the same as in
     the virtualized environment case.
     a) A UNIX socket is in place to exchange any VHOST-USER messages.
     b) EventFDs are being used in order to trigger VIRTIO kick/call
        requests.

3) Transport & Vhost-user device:
   - Since the Vrings are allocated into the Kernel's memory, vhost-user
     device needs to communicate and request access from the virtio-loopback
     driver. These requirement is served by implementing MMAP and IOCTL
system
     calls in the driver.

c) Vrings & Zero copy memory mapping mechanism:
----------------------------------------------

The vrings are allocated by the virtio driver into the kernel's memory space
and in order to be accessible by the user-space, especially by the
vhost-user
device, a new memory mapping mechanism needed to be created into the
virtio-loopback driver. The new memory mapping mechanism is based on a
page-fault handler which maps the accessed pages on-demand.

Known issues & room for improvement:
-----------------------------------

Known limitation found in the current implementation:
- The memory mapping mechanism needs improvements, in the current
  implementation the device can potentially access the whole kernel's
  memory. A more fine grained mmapping can be set by the kernel by
  narrowing down the memory block shared.

Possible next development targets might be about:
- Security checks for the memory shared with the user-space (vhost
user-device)
- Add parallel device handling for the virtio-loopback transport and adapter
- Add support for more vhost-user devices

More information:
----------------

The full description of the technology can be found in the links below:
- Virtio-loopback design document
<https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/design_docs/EG-VIRT_VOSYS_virtio_loopback_design_v1.4_2023_04_03.pdf>
- How to test the technology
<https://git.virtualopensystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/README.md>

Links for all the key components of the design can be found below:
1) Virtio-loopback-transport
<https://git.virtualopensystems.com/virtio-loopback/loopback_driver/-/tree/virtio-loopback-rfc>
2) Adapter
<https://git.virtualopensystems.com/virtio-loopback/adapter_app/-/tree/virtio-loopback-rfc>
3) Vhost-user devices in Qemu
<https://git.virtualopensystems.com/virtio-loopback/qemu/-/tree/virtio-loopback-rfc>

Virtio-loopback has been tested on RCAR-M3 board (AGL needlefish) and x86
systems (Fedora 37). The results have been found to be comparable with VDUSE
technology in virtio-blk case:
- Automotive Grade Linux All Member Meeting Spring (8-9/03/2023) -
Presentation
<https://static.sched.com/hosted_files/aglammspring2023/44/vosys_virtio-loopback-berlin_2023-03-08.pdf>
  + Activity done in the context of the AERO EU project (grant agreement No
101092850)

Thank you for taking the time to review this PoC,
I would appreciate your feedback and suggestions for improvements.

Best regards,
Timos Ampelikiotis

--000000000000c1ee5205f937ce4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear virtio-dev community,<br><br><div><div>I would like t=
o introduce you Virtio-loopback, Proof of Concept (PoC) that<br>we have bee=
n working on at Virtual Open Systems in the context of the<br>Automotive Gr=
ade Linux community (Virtualization &amp; Containers expert</div><div>group=
 - EG-VIRT).<br><br>We consider this work as a PoC and we are not currently=
 planning<br>upstream. However, if the zero-copy or any other aspect of thi=
s work<br>is interesting for other Virtio implementations, we would be glad=
 to<br>discuss more.<br><br>Overview:<br>---------<br><br>Virtio-loopback i=
s a new hardware abstraction layer designed for non-Hypervisor<br>environme=
nts based on virtio. The main objective is to enable applications<br>commun=
ication with vhost-user devices in a non-hypervisor environment.<br><br>Mor=
e in details, Virtio-loopback&#39;s design consists of a new transport<br>(=
Virtio-loopback), a user-space daemon (Adapter), and a vhost-user device.<b=
r>The data path has been implemented using the &quot;zero-copy&quot; princi=
ple, where<br>vhost-user devices access virtqueues directly in the kernel s=
pace. This first<br>implementation supports multi-queues, does not require =
virtio-protocol changes<br>and applies minor modifications to the vhost-use=
r library. Supported vhost-user<br>devices are today vhost-user-rng (both r=
ust and C version), vhost-user-input<br>and vhost-user-blk.<br><br>Motivati=
on &amp; requirements:<br>-------------------------<br><br>1. Enable the us=
age of the same user-space driver on both virtualized and<br>=C2=A0 =C2=A0n=
on-virtualized environments.<br><br>2. Maximize performance with zero copy =
design principles<br><br>3. Applications using such drivers are unchanged a=
nd transparently running in<br>=C2=A0 =C2=A0both virtualized or non-virtual=
ized environment.<br><br>Design description:<br>-------------------<br><br>=
a) Component&#39;s description:<br>--------------------------<div><br><div>=
The Virtio-loopback architecture consists of three main components describe=
d below:<br><br></div><div>1) Driver: In order to route the VIRTIO communic=
ation in user-space<br>=C2=A0 =C2=A0virtio-loopback driver was implemented =
and consists of:<br>=C2=A0 =C2=A0- A new transport layer which is based on =
virtio-mmio and it is<br>=C2=A0 =C2=A0 =C2=A0responsible of routing the rea=
d/write communication of the virtio<br>=C2=A0 =C2=A0 =C2=A0device to the ad=
apter binary.<br>=C2=A0 =C2=A0- A character device which works as an interm=
ediate layer between the<br>=C2=A0 =C2=A0 =C2=A0user-space components and t=
he transport layer. The character device helps<br>=C2=A0 =C2=A0 =C2=A0the a=
dapter to provide all the required information and initialize the<br>=C2=A0=
 =C2=A0 =C2=A0transport and at the same time, provides direct access to the=
 vrings<br>=C2=A0 =C2=A0 =C2=A0from user-space. The access to the vrings is=
 based on a memory mapping<br>=C2=A0 =C2=A0 =C2=A0mechanism which gives the=
 ability to the vhost-user device to read and<br>=C2=A0 =C2=A0 =C2=A0write =
data directly into kernel&#39;s memory without the need of any copy.<br><br=
>2) Adapter: Implements the role that QEMU had in the corresponding virtual=
ized<br>=C2=A0 =C2=A0scenario. Specifically, combines the functionality of =
two main QEMU<br>=C2=A0 =C2=A0components, virtio-mmio transport emulation a=
nd vhost-user backend, in order<br>=C2=A0 =C2=A0to work as a bridge between=
 the transport and the vhost-user device. The two<br>=C2=A0 =C2=A0main part=
s of the adapter are:<br>=C2=A0 =C2=A0- A vhost-user backend which is the m=
ain communication point with the<br>=C2=A0 =C2=A0 =C2=A0vhost-user device.<=
br>=C2=A0 =C2=A0- A virtio-emulation which handles mostly the messages comi=
ng from the<br>=C2=A0 =C2=A0 =C2=A0driver and translates them into vhost-us=
er messages/actions.<br><br>3) Vhost-user device: This components required =
only minimal modifications to<br>=C2=A0 =C2=A0make the vrings directly acce=
ssible in kernel&#39;s memory.<br><br>b) Communication between the virtio-l=
oopback components:<br>----------------------------------------------------=
---<br><br>After the describing the role of its component, a few details ne=
ed to be given<br>about how they interact with each other and the mechanism=
s used.<br><br>1) Transport &amp; Adapter:<br>=C2=A0 =C2=A0- The two compon=
ents share a communication data structure which describes<br>=C2=A0 =C2=A0 =
=C2=A0the current read/write operation requested by the transport.<br>=C2=
=A0 =C2=A0- When this data structure has been filled with all the required =
information<br>=C2=A0 =C2=A0 =C2=A0the transport triggers and EventFD and w=
aits. The adapter wakes up, takes<br>=C2=A0 =C2=A0 =C2=A0the corresponding =
actions and finally notifies and unlocks the transport<br>=C2=A0 =C2=A0 =C2=
=A0by calling an IOCTL system call.<br>=C2=A0 =C2=A0- Compared to the virtu=
alized environment scenario, the adapter calls an<br>=C2=A0 =C2=A0 =C2=A0IO=
CTL system call to the driver in place of an interrupt.<br><br>2) Adapter &=
amp; Vhost-user device:<br>=C2=A0 =C2=A0- The mechanisms used between these=
 two component are the same as in<br>=C2=A0 =C2=A0 =C2=A0the virtualized en=
vironment case.<br>=C2=A0 =C2=A0 =C2=A0a) A UNIX socket is in place to exch=
ange any VHOST-USER messages.<br>=C2=A0 =C2=A0 =C2=A0b) EventFDs are being =
used in order to trigger VIRTIO kick/call<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
quests.<br><br>3) Transport &amp; Vhost-user device:<br>=C2=A0 =C2=A0- Sinc=
e the Vrings are allocated into the Kernel&#39;s memory, vhost-user<br>=C2=
=A0 =C2=A0 =C2=A0device needs to communicate and request access from the vi=
rtio-loopback<br>=C2=A0 =C2=A0 =C2=A0driver. These requirement is served by=
 implementing MMAP and IOCTL system<br>=C2=A0 =C2=A0 =C2=A0calls in the dri=
ver.<br><br>c) Vrings &amp; Zero copy memory mapping mechanism:<br>--------=
--------------------------------------<br><br>The vrings are allocated by t=
he virtio driver into the kernel&#39;s memory space<br>and in order to be a=
ccessible by the user-space, especially by the vhost-user<br>device, a new =
memory mapping mechanism needed to be created into the<br>virtio-loopback d=
river. The new memory mapping mechanism is based on a<br>page-fault handler=
 which maps the accessed pages on-demand.<br><br>Known issues &amp; room fo=
r improvement:<br>-----------------------------------<br><br>Known limitati=
on found in the current implementation:<br>- The memory mapping mechanism n=
eeds improvements, in the current<br>=C2=A0 implementation the device can p=
otentially access the whole kernel&#39;s<br>=C2=A0 memory. A more fine grai=
ned mmapping can be set by the kernel by<br>=C2=A0 narrowing down the memor=
y block shared.<br><br>Possible next development targets might be about:<br=
>- Security checks for the memory shared with the user-space (vhost user-de=
vice)<br>- Add parallel device handling for the virtio-loopback transport a=
nd adapter<br>- Add support for more vhost-user devices<br><br>More informa=
tion:<br>----------------<br><br>The full description of the technology can=
 be found in the links below:<br>-=C2=A0<a href=3D"https://git.virtualopens=
ystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/design_docs/EG-V=
IRT_VOSYS_virtio_loopback_design_v1.4_2023_04_03.pdf" target=3D"_blank">Vir=
tio-loopback design document</a><br>-=C2=A0<a href=3D"https://git.virtualop=
ensystems.com/virtio-loopback/docs/-/blob/virtio-loopback-rfc/README.md" ta=
rget=3D"_blank">How to test the technology</a><br><br>Links for all the key=
 components of the design can be found below:<br>1)=C2=A0<a href=3D"https:/=
/git.virtualopensystems.com/virtio-loopback/loopback_driver/-/tree/virtio-l=
oopback-rfc" target=3D"_blank">Virtio-loopback-transport</a><br>2)=C2=A0<a =
href=3D"https://git.virtualopensystems.com/virtio-loopback/adapter_app/-/tr=
ee/virtio-loopback-rfc" target=3D"_blank">Adapter</a><br>3)=C2=A0<a href=3D=
"https://git.virtualopensystems.com/virtio-loopback/qemu/-/tree/virtio-loop=
back-rfc" target=3D"_blank">Vhost-user devices in Qemu</a><br><br><font fac=
e=3D"arial, sans-serif">Virtio-loopback has been tested on RCAR-M3 board (A=
GL needlefish) and x86<br>systems (Fedora 37). The results have been found =
to be comparable with VDUSE<br>technology in virtio-blk case:<br>-=C2=A0<a =
href=3D"https://static.sched.com/hosted_files/aglammspring2023/44/vosys_vir=
tio-loopback-berlin_2023-03-08.pdf" target=3D"_blank">Automotive Grade Linu=
x All Member Meeting Spring (8-9/03/2023) - Presentation</a></font></div><d=
iv><font face=3D"arial, sans-serif">=C2=A0 + Activity done in the context o=
f the AERO EU project (grant agreement No 101092850)</font><br><br>Thank yo=
u for taking the time to review this PoC,<br>I would appreciate your feedba=
ck and suggestions for improvements.<br><br>Best regards,<br>Timos Ampeliki=
otis<br></div></div></div></div></div>

--000000000000c1ee5205f937ce4b--
