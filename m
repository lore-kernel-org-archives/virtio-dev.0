Return-Path: <virtio-dev-return-13622-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A04C83F33
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 10:02:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 76CA92AD55
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 10:02:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F163986410
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 10:02:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 30F47983E51; Tue,  5 Sep 2023 10:02:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 213EC986412
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Sep 2023 10:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: q-GGFZKoOVOW9YfZlUTzww-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908134; x=1694512934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxc0QJeq5Y+u7Oj5A7b9moAiEYpmYjqKhN6in+TXGbA=;
        b=DTxxNncL1hIFJOM8UIiXOYJj8iWPAa4OJTpzJJP5aiZQpO3AvypTKfx9SsJBCE4HR+
         FDAuFKiMSQojE6miX64yKDDmoP+eRaM+9VYJ9uiTDAjt8y6j/YrM+9L64zsKipUKdDL1
         r/1Rcnqc28YwCJAn+XSxpPiLhRmYb5ASgmweUR9fEdeXa3GYFfSpo0D6TFBRIbvmXmWj
         X/tK5TlGtKtSRBvantluHvvgU9RAR5OtH23gkmJGAyeBYhu02EVAMGEWyDPZVBzNbAln
         RLwmN/L7p+h1FsY5kIlUKXDdXSCTi9JqzhoEUd4jAVc/YJuqD6r2Nc7WHVsGggeytaBB
         4PuA==
X-Gm-Message-State: AOJu0YwrIocqiVPZtbw3vTWMt4gK/oeWX/xZ9GGytDNcKcEqui+jMF37
	zEOztyNqoaLH6Ow0ZSYK90xYKeatkbea2Dq2o+5/xRfvURHGnjGgSQUn2MIBihsGQDmcvXlPBfH
	3SnHDOJ7ID/EP4o8zRJMdKxdllhid5i4JDLNrDYhQtAhp
X-Received: by 2002:a17:90a:2e0b:b0:26f:7555:76 with SMTP id q11-20020a17090a2e0b00b0026f75550076mr8409443pjd.11.1693908134587;
        Tue, 05 Sep 2023 03:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD93z6+hskVQ1Qr2PwBGbyNfddmnDYZfCNmMMrUmblWZRRqI3BPQpL/d+rDMyD6lusN2nwMvUkdtPPkZDo0j8=
X-Received: by 2002:a17:90a:2e0b:b0:26f:7555:76 with SMTP id
 q11-20020a17090a2e0b00b0026f75550076mr8409413pjd.11.1693908134218; Tue, 05
 Sep 2023 03:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com> <87y1hlgdl4.fsf@linaro.org>
In-Reply-To: <87y1hlgdl4.fsf@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 5 Sep 2023 12:02:02 +0200
Message-ID: <CADSE00L2AQ2iFjnbz9kfiOfJ3g+=6C_w6dVxuGaApWe5JRj3Ww@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, 
	stefanha@redhat.com, viresh.kumar@linaro.org, sgarzare@redhat.com, 
	takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org, 
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009f62dd060499b8d4"
Subject: Re: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature
 for vhost-user VirtIO devices

--0000000000009f62dd060499b8d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 5, 2023 at 11:43=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

>
> Albert Esteve <aesteve@redhat.com> writes:
>
> > This looks great! Thanks for this proposal.
> >
> > On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@li=
naro.org>
> wrote:
> >
> >  Currently QEMU has to know some details about the VirtIO device
> >  supported by a vhost-user daemon to be able to setup the guest. This
> >  makes it hard for QEMU to add support for additional vhost-user
> >  daemons without adding specific stubs for each additional VirtIO
> >  device.
> >
> >  This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
> >  which the back-end can advertise which allows a probe message to be
> >  sent to get all the details QEMU needs to know in one message.
> >
> >  Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
> >  VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> >  daemons which are capable of handling all aspects of the VirtIO
> >  transactions with only a generic stub on the QEMU side. These daemons
> >  can also be used without QEMU in situations where there isn't a full
> >  VMM managing their setup.
> >
> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> >  ---
> >  v2
> >    - dropped F_STANDALONE in favour of F_PROBE
> >    - split probe details across several messages
> >    - probe messages don't automatically imply a standalone daemon
> >    - add wording where probe details interact (F_MQ/F_CONFIG)
> >    - define VMM and make clear QEMU is only one of many potential VMMs
> >    - reword commit message
> >  ---
> >   docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++----=
-
> >   hw/virtio/vhost-user.c      |  8 ++++
> >   2 files changed, 88 insertions(+), 10 deletions(-)
> >
> >  diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >  index 5a070adbc1..ba3b5e07b7 100644
> >  --- a/docs/interop/vhost-user.rst
> >  +++ b/docs/interop/vhost-user.rst
> >  @@ -7,6 +7,7 @@ Vhost-user Protocol
> >   ..
> >     Copyright 2014 Virtual Open Systems Sarl.
> >     Copyright 2019 Intel Corporation
> >  +  Copyright 2023 Linaro Ltd
> >     Licence: This work is licensed under the terms of the GNU GPL,
> >              version 2 or later. See the COPYING file in the top-level
> >              directory.
> >  @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication,
> *front-end* and
> >   *back-end*. The *front-end* is the application that shares its
> virtqueues, in
> >   our case QEMU. The *back-end* is the consumer of the virtqueues.
> >
> >  -In the current implementation QEMU is the *front-end*, and the
> *back-end*
> >  -is the external process consuming the virtio queues, for example a
> >  -software Ethernet switch running in user space, such as Snabbswitch,
> >  -or a block device back-end processing read & write to a virtual
> >  -disk. In order to facilitate interoperability between various back-en=
d
> >  -implementations, it is recommended to follow the :ref:`Backend progra=
m
> >  -conventions <backend_conventions>`.
> >  +In the current implementation a Virtual Machine Manager (VMM) such as
> >  +QEMU is the *front-end*, and the *back-end* is the external process
> >  +consuming the virtio queues, for example a software Ethernet switch
> >  +running in user space, such as Snabbswitch, or a block device back-en=
d
> >  +processing read & write to a virtual disk. In order to facilitate
> >  +interoperability between various back-end implementations, it is
> >  +recommended to follow the :ref:`Backend program conventions
> >  +<backend_conventions>`.
> >
> >   The *front-end* and *back-end* can be either a client (i.e.
> connecting) or
> >   server (listening) in the socket communication.
> >
> >  +Probing device details
> >  +----------------------
> >  +
> >  +Traditionally the vhost-user daemon *back-end* shares configuration
> >  +responsibilities with the VMM *front-end* which needs to know certain
> >  +key bits of information about the device. This means the VMM needs to
> >  +define at least a minimal stub for each VirtIO device it wants to
> >  +support. If the daemon supports the right set of protocol features th=
e
> >  +VMM can probe the daemon for the information it needs to setup the
> >  +device. See :ref:`Probing features for standalone daemons
> >  +<probing_features>` for more details.
> >  +
> >  +
> >   Support for platforms other than Linux
> >   --------------------------------------
> >
> >  @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
> >   * ``VHOST_USER_GET_VRING_BASE``
> >   * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``=
)
> >   * ``VHOST_USER_GET_INFLIGHT_FD`` (if
> ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
> >  +* ``VHOST_USER_GET_BACKEND_SPECS`` (if
> ``VHOST_USER_PROTOCOL_F_STANDALONE``)
> >
> >   .. seealso::
> >
> >  @@ -396,9 +412,10 @@ must support changing some configuration aspects
> on the fly.
> >   Multiple queue support
> >   ----------------------
> >
> >  -Many devices have a fixed number of virtqueues.  In this case the
> front-end
> >  -already knows the number of available virtqueues without communicatin=
g
> with the
> >  -back-end.
> >  +Many devices have a fixed number of virtqueues. In this case the
> >  +*front-end* usually already knows the number of available virtqueues
> >  +without communicating with the back-end. For standalone daemons this
> >  +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` messag=
e.
> >
> >   Some devices do not have a fixed number of virtqueues.  Instead the
> maximum
> >   number of virtqueues is chosen by the back-end.  The number can depen=
d
> on host
> >  @@ -885,6 +902,23 @@ Protocol features
> >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> >     #define VHOST_USER_PROTOCOL_F_STATUS               16
> >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >  +  #define VHOST_USER_PROTOCOL_F_PROBE                18
> >  +
> >  +.. _probing_features:
> >  +
> >  +Probing features for standalone daemons
> >  +---------------------------------------
> >  +
> >  +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
> >  +of additional messages which allow the *front-end* to probe details
> >  +about the VirtIO device from the *back-end*. However for a *back-end*
> >  +to be described as standalone it must also support:
> >  +
> >  +  * ``VHOST_USER_PROTOCOL_F_STATUS``
> >  +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
> >  +
> >  +which are required to ensure the *back-end* daemon can operate
> >  +without the *front-end* managing some aspects of its configuration.
> >
> >   Front-end message types
> >   -----------------------
> >  @@ -1440,6 +1474,42 @@ Front-end message types
> >     query the back-end for its device status as defined in the Virtio
> >     specification.
> >
> >  +``VHOST_USER_GET_DEVICE_ID``
> >  +  :id: 41
> >  +  :request payload: N/A
> >  +  :reply payload: ``u32``
> >  +
> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> >  +  successfully negotiated, this message is submitted by the front-end
> >  +  to query what VirtIO device the back-end support. This is intended
> >  +  to remove the need for the front-end to know ahead of time what the
> >  +  VirtIO device the backend emulates is.
> >  +
> >  +``VHOST_USER_GET_CONFIG_SIZE``
> >  +  :id: 42
> >  +  :request payload: N/A
> >  +  :reply payload: ``u32``
> >  +
> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> >  +  successfully negotiated, this message is submitted by the front-end
> >  +  to query the size of the VirtIO device's config space. This is
> >  +  intended to remove the need for the front-end to know ahead of time
> >  +  what the size is. Replying with 0 when
> >  +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
> >  +  an bug.
> >  +
> >  +``VHOST_USER_GET_MIN_VQ``
> >  +  :id: 43
> >  +  :request payload: N/A
> >  +  :reply payload: ``u32``
> >  +
> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> >  +  successfully negotiated, this message is submitted by the front-end
> to
> >  +  query minimum number of VQ's required to support the device. A
> >  +  device may support more than this number of VQ's if it advertises
> >  +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
> >  +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` woul=
d
> >  +  indicate a bug.
> >
> > Maybe I lack some background, but not sure what min_vq is here?
>
> There will be a minimum number of queues you need to support the device.
> For example the virtio-sound spec specifies you need four queues:
> control, event, tx, rx
>
> > This looks like quering the number of VQs the backend requires/uses.
> > Which, in case of MQ, it may be bigger (which is where I assume comes
> the `min`
> > part, if we consider `VHOST_USER_GET_QUEUE_NUM` the `max`).
>
> The MQ extension is currently used by networking but in theory any
> device could attempt to parallelism by extending the number of virt
> queues needed. So for net you get:
>
>   receiveq1
>   transmitq1
>   optional controlq
>
> So VHOST_USER_GET_MIN_VQ would report 2 or 3 (if VIRTIO_NET_F_CTRL_VQ is
> negotiated). However VHOST_USER_GET_QUEUE_NUM is only usable if
> VIRTIO_NET_F_MQ has been negotiated and could report more.
>
>
Ah I see, I understand it better now. It is a pity that we cannot
multipurpose
the GET_QUEUE_NUM request.

FWIW:
Acked-by: Albert Esteve <aesteve@redhat.com>


> >
> > Couldn't we reuse the `VHOST_USER_GET_QUEUE_NUM` type for this?
> >
> >   Back-end message types
> >   ----------------------
> >  diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >  index 8dcf049d42..4d433cdf2b 100644
> >  --- a/hw/virtio/vhost-user.c
> >  +++ b/hw/virtio/vhost-user.c
> >  @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
> >       uint16_t queue_size;
> >   } VhostUserInflight;
> >
> >  +typedef struct VhostUserBackendSpecs {
> >  +    uint32_t device_id;
> >  +    uint32_t config_size;
> >  +    uint32_t min_vqs;
> >  +    uint32_t max_vqs;
> >  +} VhostUserBackendSpecs;
> >  +
> >   typedef struct {
> >       VhostUserRequest request;
> >
> >  @@ -226,6 +233,7 @@ typedef union {
> >           VhostUserCryptoSession session;
> >           VhostUserVringArea area;
> >           VhostUserInflight inflight;
> >  +        VhostUserBackendSpecs specs;
>
> Oops these snuck in, I shall clean them up
>
> >   } VhostUserPayload;
> >
> >   typedef struct VhostUserMsg {
> >  --
> >  2.39.2
> >
> >  ---------------------------------------------------------------------
> >  To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >  For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--0000000000009f62dd060499b8d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 5, 2023 at 11:43=
=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">=
alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"_blank">a=
esteve@redhat.com</a>&gt; writes:<br>
<br>
&gt; This looks great! Thanks for this proposal.<br>
&gt;<br>
&gt; On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D=
"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a=
>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Currently QEMU has to know some details about the VirtIO device<=
br>
&gt;=C2=A0 supported by a vhost-user daemon to be able to setup the guest. =
This<br>
&gt;=C2=A0 makes it hard for QEMU to add support for additional vhost-user<=
br>
&gt;=C2=A0 daemons without adding specific stubs for each additional VirtIO=
<br>
&gt;=C2=A0 device.<br>
&gt;<br>
&gt;=C2=A0 This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PR=
OBE)<br>
&gt;=C2=A0 which the back-end can advertise which allows a probe message to=
 be<br>
&gt;=C2=A0 sent to get all the details QEMU needs to know in one message.<b=
r>
&gt;<br>
&gt;=C2=A0 Together with the existing features VHOST_USER_PROTOCOL_F_STATUS=
 and<br>
&gt;=C2=A0 VHOST_USER_PROTOCOL_F_CONFIG we can create &quot;standalone&quot=
; vhost-user<br>
&gt;=C2=A0 daemons which are capable of handling all aspects of the VirtIO<=
br>
&gt;=C2=A0 transactions with only a generic stub on the QEMU side. These da=
emons<br>
&gt;=C2=A0 can also be used without QEMU in situations where there isn&#39;=
t a full<br>
&gt;=C2=A0 VMM managing their setup.<br>
&gt;<br>
&gt;=C2=A0 Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 ---<br>
&gt;=C2=A0 v2<br>
&gt;=C2=A0 =C2=A0 - dropped F_STANDALONE in favour of F_PROBE<br>
&gt;=C2=A0 =C2=A0 - split probe details across several messages<br>
&gt;=C2=A0 =C2=A0 - probe messages don&#39;t automatically imply a standalo=
ne daemon<br>
&gt;=C2=A0 =C2=A0 - add wording where probe details interact (F_MQ/F_CONFIG=
)<br>
&gt;=C2=A0 =C2=A0 - define VMM and make clear QEMU is only one of many pote=
ntial VMMs<br>
&gt;=C2=A0 =C2=A0 - reword commit message<br>
&gt;=C2=A0 ---<br>
&gt;=C2=A0 =C2=A0docs/interop/vhost-user.rst | 90 +++++++++++++++++++++++++=
+++++++-----<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++<=
br>
&gt;=C2=A0 =C2=A02 files changed, 88 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt;=C2=A0 diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-us=
er.rst<br>
&gt;=C2=A0 index 5a070adbc1..ba3b5e07b7 100644<br>
&gt;=C2=A0 --- a/docs/interop/vhost-user.rst<br>
&gt;=C2=A0 +++ b/docs/interop/vhost-user.rst<br>
&gt;=C2=A0 @@ -7,6 +7,7 @@ Vhost-user Protocol<br>
&gt;=C2=A0 =C2=A0..<br>
&gt;=C2=A0 =C2=A0 =C2=A0Copyright 2014 Virtual Open Systems Sarl.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Copyright 2019 Intel Corporation<br>
&gt;=C2=A0 +=C2=A0 Copyright 2023 Linaro Ltd<br>
&gt;=C2=A0 =C2=A0 =C2=A0Licence: This work is licensed under the terms of t=
he GNU GPL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version 2 or later. Se=
e the COPYING file in the top-level<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 directory.<br>
&gt;=C2=A0 @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communic=
ation, *front-end* and<br>
&gt;=C2=A0 =C2=A0*back-end*. The *front-end* is the application that shares=
 its virtqueues, in<br>
&gt;=C2=A0 =C2=A0our case QEMU. The *back-end* is the consumer of the virtq=
ueues.<br>
&gt;<br>
&gt;=C2=A0 -In the current implementation QEMU is the *front-end*, and the =
*back-end*<br>
&gt;=C2=A0 -is the external process consuming the virtio queues, for exampl=
e a<br>
&gt;=C2=A0 -software Ethernet switch running in user space, such as Snabbsw=
itch,<br>
&gt;=C2=A0 -or a block device back-end processing read &amp; write to a vir=
tual<br>
&gt;=C2=A0 -disk. In order to facilitate interoperability between various b=
ack-end<br>
&gt;=C2=A0 -implementations, it is recommended to follow the :ref:`Backend =
program<br>
&gt;=C2=A0 -conventions &lt;backend_conventions&gt;`.<br>
&gt;=C2=A0 +In the current implementation a Virtual Machine Manager (VMM) s=
uch as<br>
&gt;=C2=A0 +QEMU is the *front-end*, and the *back-end* is the external pro=
cess<br>
&gt;=C2=A0 +consuming the virtio queues, for example a software Ethernet sw=
itch<br>
&gt;=C2=A0 +running in user space, such as Snabbswitch, or a block device b=
ack-end<br>
&gt;=C2=A0 +processing read &amp; write to a virtual disk. In order to faci=
litate<br>
&gt;=C2=A0 +interoperability between various back-end implementations, it i=
s<br>
&gt;=C2=A0 +recommended to follow the :ref:`Backend program conventions<br>
&gt;=C2=A0 +&lt;backend_conventions&gt;`.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0The *front-end* and *back-end* can be either a client (i.e=
. connecting) or<br>
&gt;=C2=A0 =C2=A0server (listening) in the socket communication.<br>
&gt;<br>
&gt;=C2=A0 +Probing device details<br>
&gt;=C2=A0 +----------------------<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +Traditionally the vhost-user daemon *back-end* shares configura=
tion<br>
&gt;=C2=A0 +responsibilities with the VMM *front-end* which needs to know c=
ertain<br>
&gt;=C2=A0 +key bits of information about the device. This means the VMM ne=
eds to<br>
&gt;=C2=A0 +define at least a minimal stub for each VirtIO device it wants =
to<br>
&gt;=C2=A0 +support. If the daemon supports the right set of protocol featu=
res the<br>
&gt;=C2=A0 +VMM can probe the daemon for the information it needs to setup =
the<br>
&gt;=C2=A0 +device. See :ref:`Probing features for standalone daemons<br>
&gt;=C2=A0 +&lt;probing_features&gt;` for more details.<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 =C2=A0Support for platforms other than Linux<br>
&gt;=C2=A0 =C2=A0--------------------------------------<br>
&gt;<br>
&gt;=C2=A0 @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:=
<br>
&gt;=C2=A0 =C2=A0* ``VHOST_USER_GET_VRING_BASE``<br>
&gt;=C2=A0 =C2=A0* ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_=
LOG_SHMFD``)<br>
&gt;=C2=A0 =C2=A0* ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL=
_F_INFLIGHT_SHMFD``)<br>
&gt;=C2=A0 +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_=
STANDALONE``)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0.. seealso::<br>
&gt;<br>
&gt;=C2=A0 @@ -396,9 +412,10 @@ must support changing some configuration as=
pects on the fly.<br>
&gt;=C2=A0 =C2=A0Multiple queue support<br>
&gt;=C2=A0 =C2=A0----------------------<br>
&gt;<br>
&gt;=C2=A0 -Many devices have a fixed number of virtqueues.=C2=A0 In this c=
ase the front-end<br>
&gt;=C2=A0 -already knows the number of available virtqueues without commun=
icating with the<br>
&gt;=C2=A0 -back-end.<br>
&gt;=C2=A0 +Many devices have a fixed number of virtqueues. In this case th=
e<br>
&gt;=C2=A0 +*front-end* usually already knows the number of available virtq=
ueues<br>
&gt;=C2=A0 +without communicating with the back-end. For standalone daemons=
 this<br>
&gt;=C2=A0 +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` =
message.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Some devices do not have a fixed number of virtqueues.=C2=
=A0 Instead the maximum<br>
&gt;=C2=A0 =C2=A0number of virtqueues is chosen by the back-end.=C2=A0 The =
number can depend on host<br>
&gt;=C2=A0 @@ -885,6 +902,23 @@ Protocol features<br>
&gt;=C2=A0 =C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS=
=C2=A0 15<br>
&gt;=C2=A0 =C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_STATUS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt;=C2=A0 =C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_XEN_MMAP=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A017<br>
&gt;=C2=A0 +=C2=A0 #define VHOST_USER_PROTOCOL_F_PROBE=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 18<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +.. _probing_features:<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +Probing features for standalone daemons<br>
&gt;=C2=A0 +---------------------------------------<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a =
number<br>
&gt;=C2=A0 +of additional messages which allow the *front-end* to probe det=
ails<br>
&gt;=C2=A0 +about the VirtIO device from the *back-end*. However for a *bac=
k-end*<br>
&gt;=C2=A0 +to be described as standalone it must also support:<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +=C2=A0 * ``VHOST_USER_PROTOCOL_F_STATUS``<br>
&gt;=C2=A0 +=C2=A0 * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config=
 space)<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +which are required to ensure the *back-end* daemon can operate<=
br>
&gt;=C2=A0 +without the *front-end* managing some aspects of its configurat=
ion.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Front-end message types<br>
&gt;=C2=A0 =C2=A0-----------------------<br>
&gt;=C2=A0 @@ -1440,6 +1474,42 @@ Front-end message types<br>
&gt;=C2=A0 =C2=A0 =C2=A0query the back-end for its device status as defined=
 in the Virtio<br>
&gt;=C2=A0 =C2=A0 =C2=A0specification.<br>
&gt;<br>
&gt;=C2=A0 +``VHOST_USER_GET_DEVICE_ID``<br>
&gt;=C2=A0 +=C2=A0 :id: 41<br>
&gt;=C2=A0 +=C2=A0 :request payload: N/A<br>
&gt;=C2=A0 +=C2=A0 :reply payload: ``u32``<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol featur=
e has been<br>
&gt;=C2=A0 +=C2=A0 successfully negotiated, this message is submitted by th=
e front-end<br>
&gt;=C2=A0 +=C2=A0 to query what VirtIO device the back-end support. This i=
s intended<br>
&gt;=C2=A0 +=C2=A0 to remove the need for the front-end to know ahead of ti=
me what the<br>
&gt;=C2=A0 +=C2=A0 VirtIO device the backend emulates is.<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +``VHOST_USER_GET_CONFIG_SIZE``<br>
&gt;=C2=A0 +=C2=A0 :id: 42<br>
&gt;=C2=A0 +=C2=A0 :request payload: N/A<br>
&gt;=C2=A0 +=C2=A0 :reply payload: ``u32``<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol featur=
e has been<br>
&gt;=C2=A0 +=C2=A0 successfully negotiated, this message is submitted by th=
e front-end<br>
&gt;=C2=A0 +=C2=A0 to query the size of the VirtIO device&#39;s config spac=
e. This is<br>
&gt;=C2=A0 +=C2=A0 intended to remove the need for the front-end to know ah=
ead of time<br>
&gt;=C2=A0 +=C2=A0 what the size is. Replying with 0 when<br>
&gt;=C2=A0 +=C2=A0 ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated wou=
ld indicate<br>
&gt;=C2=A0 +=C2=A0 an bug.<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +``VHOST_USER_GET_MIN_VQ``<br>
&gt;=C2=A0 +=C2=A0 :id: 43<br>
&gt;=C2=A0 +=C2=A0 :request payload: N/A<br>
&gt;=C2=A0 +=C2=A0 :reply payload: ``u32``<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol featur=
e has been<br>
&gt;=C2=A0 +=C2=A0 successfully negotiated, this message is submitted by th=
e front-end to<br>
&gt;=C2=A0 +=C2=A0 query minimum number of VQ&#39;s required to support the=
 device. A<br>
&gt;=C2=A0 +=C2=A0 device may support more than this number of VQ&#39;s if =
it advertises<br>
&gt;=C2=A0 +=C2=A0 the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Repor=
ting a<br>
&gt;=C2=A0 +=C2=A0 number greater than the result of ``VHOST_USER_GET_QUEUE=
_NUM`` would<br>
&gt;=C2=A0 +=C2=A0 indicate a bug.<br>
&gt;<br>
&gt; Maybe I lack some background, but not sure what min_vq is here?<br>
<br>
There will be a minimum number of queues you need to support the device.<br=
>
For example the virtio-sound spec specifies you need four queues:<br>
control, event, tx, rx<br>
<br>
&gt; This looks like quering the number of VQs the backend requires/uses.<b=
r>
&gt; Which, in case of MQ, it may be bigger (which is where I assume comes =
the `min`<br>
&gt; part, if we consider `VHOST_USER_GET_QUEUE_NUM` the `max`).<br>
<br>
The MQ extension is currently used by networking but in theory any<br>
device could attempt to parallelism by extending the number of virt<br>
queues needed. So for net you get:<br>
<br>
=C2=A0 receiveq1<br>
=C2=A0 transmitq1<br>
=C2=A0 optional controlq<br>
<br>
So VHOST_USER_GET_MIN_VQ would report 2 or 3 (if VIRTIO_NET_F_CTRL_VQ is<br=
>
negotiated). However VHOST_USER_GET_QUEUE_NUM is only usable if<br>
VIRTIO_NET_F_MQ has been negotiated and could report more.<br>
<br></blockquote><div><br></div><div>Ah I see, I understand it better now. =
It is a pity=C2=A0that we cannot multipurpose</div><div>the GET_QUEUE_NUM r=
equest.</div><div><br></div><div>FWIW:</div><div>Acked-by: Albert Esteve &l=
t;<a href=3D"mailto:aesteve@redhat.com">aesteve@redhat.com</a>&gt;<br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Couldn&#39;t we reuse the `VHOST_USER_GET_QUEUE_NUM` type for this?<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0Back-end message types<br>
&gt;=C2=A0 =C2=A0----------------------<br>
&gt;=C2=A0 diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt;=C2=A0 index 8dcf049d42..4d433cdf2b 100644<br>
&gt;=C2=A0 --- a/hw/virtio/vhost-user.c<br>
&gt;=C2=A0 +++ b/hw/virtio/vhost-user.c<br>
&gt;=C2=A0 @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t queue_size;<br>
&gt;=C2=A0 =C2=A0} VhostUserInflight;<br>
&gt;<br>
&gt;=C2=A0 +typedef struct VhostUserBackendSpecs {<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 uint32_t device_id;<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 uint32_t config_size;<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 uint32_t min_vqs;<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 uint32_t max_vqs;<br>
&gt;=C2=A0 +} VhostUserBackendSpecs;<br>
&gt;=C2=A0 +<br>
&gt;=C2=A0 =C2=A0typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserRequest request;<br>
&gt;<br>
&gt;=C2=A0 @@ -226,6 +233,7 @@ typedef union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserCryptoSession session=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserInflight inflight;<br=
>
&gt;=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserBackendSpecs specs;<br>
<br>
Oops these snuck in, I shall clean them up<br>
<br>
&gt;=C2=A0 =C2=A0} VhostUserPayload;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0typedef struct VhostUserMsg {<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 2.39.2<br>
&gt;<br>
&gt;=C2=A0 ----------------------------------------------------------------=
-----<br>
&gt;=C2=A0 To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe=
@lists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis=
-open.org</a><br>
&gt;=C2=A0 For additional commands, e-mail: <a href=3D"mailto:virtio-dev-he=
lp@lists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open=
.org</a><br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div>

--0000000000009f62dd060499b8d4--

