Return-Path: <virtio-dev-return-13656-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A07EE14D8
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 12:03:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED4E1335BD
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 12:03:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA72798662A
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 12:03:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CB99098646D; Fri,  8 Sep 2023 12:03:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB0CE98644C
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Sep 2023 12:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694174582; x=1694779382;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=usGbO52px+d14iZwGFx0u9Kcrr0MplJaiZE9VDoQlxE=;
        b=TM80PxGgZ5jkfGmfmy5AhxDIfqImCwj60mm6u4f0SCDUGhBk0S9eQ3qpNxE/Q4vKZe
         wr6ftxpXZ0AMP6toaIvzwDGx7BlYj2CchpW1HGApjpL9FIaKaJyHkwYzqvseXHTkeaE4
         73g0mCCFJCat/MkKNLFOSrNyeKz1KFGR7AFw7VKvQZ66g812Ks32tdN8bURJxo1u4x2l
         4z2hzDkhYJkdeAueaitT95DxO8L7y72cJewsbTh4/un4GP+xfwfeqnilpXNxOYkO4ZB6
         xr34yrpT8wtDLE3K4sixsGxX+a2rc8ObIDOadSR/l5kEJj/i2dm/anLwFKalPxu3gmFG
         NSIQ==
X-Gm-Message-State: AOJu0YytB6NLwZ9YVsMf0a/XEIAekJvpWCm0Du8FQQ9ru/7u4RZMkUoo
	64c7V5V0xlCOxsOPNa3FF+aU5Q==
X-Google-Smtp-Source: AGHT+IH8Fv8U/Yc7OdSqJBfJbSzcLVE2OE5vi3qQ+KnSLMI4qLmMpBGYPIxFXkvojWjnliwMGGtLgA==
X-Received: by 2002:a05:6000:180b:b0:319:6caa:ada2 with SMTP id m11-20020a056000180b00b003196caaada2mr1672993wrh.47.1694174582462;
        Fri, 08 Sep 2023 05:03:02 -0700 (PDT)
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com>
 <87y1hlgdl4.fsf@linaro.org> <20230907192913.GD1560640@fedora>
 <87h6o517yh.fsf@linaro.org>
 <CAJSP0QW_ZFweKH5KTEyr61Scn7VL91+-PiTUfxkMwx8+ZmiU2w@mail.gmail.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Albert Esteve
 <aesteve@redhat.com>, slp@redhat.com, mst@redhat.com,
 marcandre.lureau@redhat.com, viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Date: Fri, 08 Sep 2023 12:59:49 +0100
In-reply-to: <CAJSP0QW_ZFweKH5KTEyr61Scn7VL91+-PiTUfxkMwx8+ZmiU2w@mail.gmail.com>
Message-ID: <87zg1wzxca.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature
 for vhost-user VirtIO devices


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, 8 Sept 2023 at 02:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>
>> > On Tue, Sep 05, 2023 at 10:34:11AM +0100, Alex Benn=C3=A9e wrote:
>> >>
>> >> Albert Esteve <aesteve@redhat.com> writes:
>> >>
>> >> > This looks great! Thanks for this proposal.
>> >> >
>> >> > On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.benne=
e@linaro.org> wrote:
>> >> >
>> >> >  Currently QEMU has to know some details about the VirtIO device
>> >> >  supported by a vhost-user daemon to be able to setup the guest. Th=
is
>> >> >  makes it hard for QEMU to add support for additional vhost-user
>> >> >  daemons without adding specific stubs for each additional VirtIO
>> >> >  device.
>> >> >
>> >> >  This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROB=
E)
>> >> >  which the back-end can advertise which allows a probe message to be
>> >> >  sent to get all the details QEMU needs to know in one message.
>> >> >
>> >> >  Together with the existing features VHOST_USER_PROTOCOL_F_STATUS a=
nd
>> >> >  VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
>> >> >  daemons which are capable of handling all aspects of the VirtIO
>> >> >  transactions with only a generic stub on the QEMU side. These daem=
ons
>> >> >  can also be used without QEMU in situations where there isn't a fu=
ll
>> >> >  VMM managing their setup.
>> >> >
>> >> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> >
>> >> >  ---
>> >> >  v2
>> >> >    - dropped F_STANDALONE in favour of F_PROBE
>> >> >    - split probe details across several messages
>> >> >    - probe messages don't automatically imply a standalone daemon
>> >> >    - add wording where probe details interact (F_MQ/F_CONFIG)
>> >> >    - define VMM and make clear QEMU is only one of many potential V=
MMs
>> >> >    - reword commit message
>> >> >  ---
>> >> >   docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++=
-----
>> >> >   hw/virtio/vhost-user.c      |  8 ++++
>> >> >   2 files changed, 88 insertions(+), 10 deletions(-)
>> >> >
>> >> >  diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user=
.rst
>> >> >  index 5a070adbc1..ba3b5e07b7 100644
>> >> >  --- a/docs/interop/vhost-user.rst
>> >> >  +++ b/docs/interop/vhost-user.rst
>> >> >  @@ -7,6 +7,7 @@ Vhost-user Protocol
>> >> >   ..
>> >> >     Copyright 2014 Virtual Open Systems Sarl.
>> >> >     Copyright 2019 Intel Corporation
>> >> >  +  Copyright 2023 Linaro Ltd
>> >> >     Licence: This work is licensed under the terms of the GNU GPL,
>> >> >              version 2 or later. See the COPYING file in the top-le=
vel
>> >> >              directory.
>> >> >  @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communicat=
ion, *front-end* and
>> >> >   *back-end*. The *front-end* is the application that shares its vi=
rtqueues, in
>> >> >   our case QEMU. The *back-end* is the consumer of the virtqueues.
>> >> >
>> >> >  -In the current implementation QEMU is the *front-end*, and the *b=
ack-end*
>> >> >  -is the external process consuming the virtio queues, for example a
>> >> >  -software Ethernet switch running in user space, such as Snabbswit=
ch,
>> >> >  -or a block device back-end processing read & write to a virtual
>> >> >  -disk. In order to facilitate interoperability between various bac=
k-end
>> >> >  -implementations, it is recommended to follow the :ref:`Backend pr=
ogram
>> >> >  -conventions <backend_conventions>`.
>> >> >  +In the current implementation a Virtual Machine Manager (VMM) suc=
h as
>> >> >  +QEMU is the *front-end*, and the *back-end* is the external proce=
ss
>> >> >  +consuming the virtio queues, for example a software Ethernet swit=
ch
>> >> >  +running in user space, such as Snabbswitch, or a block device bac=
k-end
>> >> >  +processing read & write to a virtual disk. In order to facilitate
>> >> >  +interoperability between various back-end implementations, it is
>> >> >  +recommended to follow the :ref:`Backend program conventions
>> >> >  +<backend_conventions>`.
>> >> >
>> >> >   The *front-end* and *back-end* can be either a client (i.e. conne=
cting) or
>> >> >   server (listening) in the socket communication.
>> >> >
>> >> >  +Probing device details
>> >> >  +----------------------
>> >> >  +
>> >> >  +Traditionally the vhost-user daemon *back-end* shares configurati=
on
>> >> >  +responsibilities with the VMM *front-end* which needs to know cer=
tain
>> >> >  +key bits of information about the device. This means the VMM need=
s to
>> >> >  +define at least a minimal stub for each VirtIO device it wants to
>> >> >  +support. If the daemon supports the right set of protocol feature=
s the
>> >> >  +VMM can probe the daemon for the information it needs to setup the
>> >> >  +device. See :ref:`Probing features for standalone daemons
>> >> >  +<probing_features>` for more details.
>> >> >  +
>> >> >  +
>> >> >   Support for platforms other than Linux
>> >> >   --------------------------------------
>> >> >
>> >> >  @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
>> >> >   * ``VHOST_USER_GET_VRING_BASE``
>> >> >   * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHM=
FD``)
>> >> >   * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFL=
IGHT_SHMFD``)
>> >> >  +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_ST=
ANDALONE``)
>> >> >
>> >> >   .. seealso::
>> >> >
>> >> >  @@ -396,9 +412,10 @@ must support changing some configuration aspe=
cts on the fly.
>> >> >   Multiple queue support
>> >> >   ----------------------
>> >> >
>> >> >  -Many devices have a fixed number of virtqueues.  In this case the=
 front-end
>> >> >  -already knows the number of available virtqueues without communic=
ating with the
>> >> >  -back-end.
>> >> >  +Many devices have a fixed number of virtqueues. In this case the
>> >> >  +*front-end* usually already knows the number of available virtque=
ues
>> >> >  +without communicating with the back-end. For standalone daemons t=
his
>> >> >  +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` me=
ssage.
>> >> >
>> >> >   Some devices do not have a fixed number of virtqueues.  Instead t=
he maximum
>> >> >   number of virtqueues is chosen by the back-end.  The number can d=
epend on host
>> >> >  @@ -885,6 +902,23 @@ Protocol features
>> >> >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>> >> >     #define VHOST_USER_PROTOCOL_F_STATUS               16
>> >> >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> >> >  +  #define VHOST_USER_PROTOCOL_F_PROBE                18
>> >> >  +
>> >> >  +.. _probing_features:
>> >> >  +
>> >> >  +Probing features for standalone daemons
>> >> >  +---------------------------------------
>> >> >  +
>> >> >  +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a nu=
mber
>> >> >  +of additional messages which allow the *front-end* to probe detai=
ls
>> >> >  +about the VirtIO device from the *back-end*. However for a *back-=
end*
>> >> >  +to be described as standalone it must also support:
>> >> >  +
>> >> >  +  * ``VHOST_USER_PROTOCOL_F_STATUS``
>> >> >  +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
>> >> >  +
>> >> >  +which are required to ensure the *back-end* daemon can operate
>> >> >  +without the *front-end* managing some aspects of its configuratio=
n.
>> >> >
>> >> >   Front-end message types
>> >> >   -----------------------
>> >> >  @@ -1440,6 +1474,42 @@ Front-end message types
>> >> >     query the back-end for its device status as defined in the Virt=
io
>> >> >     specification.
>> >> >
>> >> >  +``VHOST_USER_GET_DEVICE_ID``
>> >> >  +  :id: 41
>> >> >  +  :request payload: N/A
>> >> >  +  :reply payload: ``u32``
>> >> >  +
>> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has b=
een
>> >> >  +  successfully negotiated, this message is submitted by the front=
-end
>> >> >  +  to query what VirtIO device the back-end support. This is inten=
ded
>> >> >  +  to remove the need for the front-end to know ahead of time what=
 the
>> >> >  +  VirtIO device the backend emulates is.
>> >> >  +
>> >> >  +``VHOST_USER_GET_CONFIG_SIZE``
>> >> >  +  :id: 42
>> >> >  +  :request payload: N/A
>> >> >  +  :reply payload: ``u32``
>> >> >  +
>> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has b=
een
>> >> >  +  successfully negotiated, this message is submitted by the front=
-end
>> >> >  +  to query the size of the VirtIO device's config space. This is
>> >> >  +  intended to remove the need for the front-end to know ahead of =
time
>> >> >  +  what the size is. Replying with 0 when
>> >> >  +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indi=
cate
>> >> >  +  an bug.
>> >> >  +
>> >> >  +``VHOST_USER_GET_MIN_VQ``
>> >> >  +  :id: 43
>> >> >  +  :request payload: N/A
>> >> >  +  :reply payload: ``u32``
>> >> >  +
>> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has b=
een
>> >> >  +  successfully negotiated, this message is submitted by the front=
-end to
>> >> >  +  query minimum number of VQ's required to support the device. A
>> >> >  +  device may support more than this number of VQ's if it advertis=
es
>> >> >  +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
>> >> >  +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` =
would
>> >> >  +  indicate a bug.
>> >> >
>> >> > Maybe I lack some background, but not sure what min_vq is here?
>> >>
>> >> There will be a minimum number of queues you need to support the devi=
ce.
>> >> For example the virtio-sound spec specifies you need four queues:
>> >> control, event, tx, rx
>> >
>> > I don't understand why the front-end needs to know that? The backend
>> > already reports the number of queues and not all of them need to be
>> > initialized by the driver.
>>
>> But how many don't need to be initialised? We can't just skip:
>>
>>     /* Allocate queues */
>>     vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
>>     for (int i =3D 0; i < vub->num_vqs; i++) {
>>         g_ptr_array_add(vub->vqs,
>>                         virtio_add_queue(vdev, vub->vq_size, vub_handle_=
output));
>>     }
>>
>> Or are you saying just require probe-able backends to support
>> VHOST_USER_PROTOCOL_F_MQ and have it always report the minimmum number
>> of queues if it is not a MQ capable device?
>
> The front-end should prepare to allow the maximum number of virtqueues
> returned by VHOST_USER_GET_QUEUE_NUM (VHOST_USER_PROTOCOL_F_MQ).
>
> VIRTIO Transports have a way to query the maximum number of queues but
> not a way to query the minimum number of queues. Why is the minimum
> necessary?

It seems excessive to automatically create the maximum number of VQs. I
guess for backends that don't support the MQ feature (i.e. a variable
number of VQs) we could just say VHOST_USER_GET_QUEUE_NUM =3D=3D min. But
now we are overloading a different message originally added for
something else.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

