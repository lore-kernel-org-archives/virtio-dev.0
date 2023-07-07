Return-Path: <virtio-dev-return-13303-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC2BC001B0
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:11:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6ED6A2AED9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:11:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 502BB9867F9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:11:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 39F73984091; Fri,  7 Jul 2023 08:11:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 261739867EB
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 08:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717480; x=1691309480;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZSiuHkgL0yIE4O7HLzt7OeU1T4BdYuO8GxB/QwP7IE=;
        b=CQaNFT1QL3zycWZyyux9BZ0131iIjqfHG9gRs6pGkiujTF+hIntvGQn6fYbXQvzqiX
         RXrVPKEiXep7yMXdSCpu+uhMIbQ+9fYbdXXX3GP7APXHxXbYPJzlNYy5sqpGIfLU9Ak1
         hXF67vxvrGmxPX15xm48Ev8uLAMjWUiTIag3Wrv4yT/t26C9bVG45qmZeOFWR5Pjtaxj
         egINpIAQoYt91BpMptgBBlLEdfAfrOGzZ+fzl6Yx2T4m/I7V6mSg1SzIdMiH7JxHcSCF
         gNSjXMrui2QgCWnylTZMe4Kefn8eQHhhE4aSXnaiC3bXy+CA+KD6q5wgZ6xoQN6cfV+f
         +kYA==
X-Gm-Message-State: ABy/qLbKt1otkAU1voMtfSyGbsCRTnlCUlFXeYYAJLM4j8Ci1Y2BZWdj
	fCbpaOo0MWsLN6D1KsPtl4WQnQ==
X-Google-Smtp-Source: APBJJlELgNlFsG5To0sX/neKfbROvRH2npY/Vu4w+FYIb8dQp2oL4hHsoTptBpUvIg2XpjB0R41XKQ==
X-Received: by 2002:adf:f809:0:b0:314:421f:532f with SMTP id s9-20020adff809000000b00314421f532fmr3564042wrp.44.1688717480600;
        Fri, 07 Jul 2023 01:11:20 -0700 (PDT)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 marcandre.lureau@redhat.com, stefanha@redhat.com, viresh.kumar@linaro.org,
 sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Date: Fri, 07 Jul 2023 08:58:00 +0100
In-reply-to: <20230706124347-mutt-send-email-mst@kernel.org>
Message-ID: <87ilawdtug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature
 for vhost-user


"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
>> Currently QEMU has to know some details about the back-end to be able
>> to setup the guest. While various parts of the setup can be delegated
>> to the backend (for example config handling) this is a very piecemeal
>> approach.
>
>> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>> which the back-end can advertise which allows a probe message to be
>> sent to get all the details QEMU needs to know in one message.
>
> The reason we do piecemeal is that these existing pieces can be reused
> as others evolve or fall by wayside.

Sure I have no objection in principle but we then turn code like:

        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STANDAL=
ONE)) {
            err =3D vhost_user_get_backend_specs(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_specs fai=
led");
                return -EPROTO;
            }
        }

to

        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_ID) &&
            dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_CFGSZ) =
&&
            dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MINVQ) =
&&
            dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MAXVQ)
        ) {
            err =3D vhost_user_get_virtio_id(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_id failed=
");
                return -EPROTO;
            }
            err =3D vhost_user_get_virtio_cfgsz(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_cfgsz fai=
led");
                return -EPROTO;
            }
            err =3D vhost_user_get_virtio_minvq(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_minvq fai=
led");
                return -EPROTO;
            }
            err =3D vhost_user_get_virtio_maxvq(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_maxvq fai=
led");
                return -EPROTO;
            }
            dev->specs.valid =3D true;
        }

for little gain IMHO.

> For example, I can think of instances where you want to connect
> specifically to e.g. networking backend, and specify it
> on command line. Reasons could be many, e.g. for debugging,
> or to prevent connecting to wrong device on wrong channel
> (kind of like type safety).

I don't quite follow what you are trying to say here.

> What is the reason to have 1 message? startup latency?
> How about we allow pipelining several messages then?
> Will be easier.

I'm not overly worried about performance because this is all at
start-up. I am worried about excessive complexity though. We already
have quite a lot of interacting protocol messages.

>
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> Initial RFC for discussion. I intend to prototype this work with QEMU
>> and one of the rust-vmm vhost-user daemons.
>> ---
>>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>>  hw/virtio/vhost-user.c      |  8 ++++++++
>>  2 files changed, 45 insertions(+)
>>=20
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..85b1b1583a 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -275,6 +275,21 @@ Inflight description
>>=20=20
>>  :queue size: a 16-bit size of virtqueues
>>=20=20
>> +Backend specifications
>> +^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-----------+-------------+------------+------------+
>> +| device id | config size |   min_vqs  |   max_vqs  |
>> ++-----------+-------------+------------+------------+
>> +
>> +:device id: a 32-bit value holding the VirtIO device ID
>> +
>> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_=
GET_CONFIG``)
>> +
>> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
>> +
>> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, m=
ust be >=3D min_vqs
>> +
>
> looks like a weird set of info.

It's basically the information you need for -device vhost-user-device to
start-up (and what is essentially the information set by the stubs as
they start-up).

> why would we want # of vqs and not their sizes?

I thought the vring's themselves where allocated by the driver. We only
need to the number of vqs so we can allocate the tracking structures.

> why config size but not config itself?

We already have GET_CONFIG and SET_CONFIG but without knowing the size
of the config space we can't properly set it up.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

