Return-Path: <virtio-dev-return-13314-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7B4EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 13:20:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 225E02B039
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 13:20:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFF3F986813
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 13:20:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CC1E8986808; Fri,  7 Jul 2023 13:20:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DD22986809
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 13:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735982; x=1691327982;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VFETEHm3ABAGQiP2zk7MYYD08U3lBq2CA5WgGuw/fMQ=;
        b=GLNKFLkASHZXeW5/uALv8BTSX2CZYMpgdLLAyUjQsYgSW4SMVB998d108j/bkO5Sv1
         GHlm7hWQul5MbFwsYobkUP6t7Bu3FQXO4NfkU/nZbOesverGd6WGVhS4lFio4OwfRBM2
         5xuRRVnkc/I+MmU5HJDFnPv5q9ZiyMFuIx7+jIYVTiFdg2cdX2TBZLt5eNFWgROjfaAQ
         DIADfnTgMkZExRike5wyNyncQht/YN1MYw6JQkB7JFO98igfBZTLrf4o1rnG+7wM80UK
         vrmHRNxJmFnRxfy9vrmsV+cbeT3QHPHoQ8XcSQfZflpD5O2PYSsAyImmhV5jBA+Raex8
         321A==
X-Gm-Message-State: ABy/qLY9wMCqQ0Ou5t2uQiH3T79tbaRIOCMH6z8g1Gg6Ni3z6PbDYB0G
	mu1AiUrFU4761codjjDKkKoglw==
X-Google-Smtp-Source: APBJJlFJrwJCJwHf/thg9C72g3BwOEwfKuTvlGwTvAMer8pco/B+AXrfX86mIiie1a/HyVe0Z8l3hg==
X-Received: by 2002:a19:4f10:0:b0:4fb:9129:705b with SMTP id d16-20020a194f10000000b004fb9129705bmr3907521lfb.6.1688735981859;
        Fri, 07 Jul 2023 06:19:41 -0700 (PDT)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <87ilawdtug.fsf@linaro.org>
 <20230707055141-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 marcandre.lureau@redhat.com, stefanha@redhat.com, viresh.kumar@linaro.org,
 sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Date: Fri, 07 Jul 2023 14:12:28 +0100
In-reply-to: <20230707055141-mutt-send-email-mst@kernel.org>
Message-ID: <87a5w7eu4y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature
 for vhost-user


"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Jul 07, 2023 at 08:58:00AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
>> >> Currently QEMU has to know some details about the back-end to be able
>> >> to setup the guest. While various parts of the setup can be delegated
>> >> to the backend (for example config handling) this is a very piecemeal
>> >> approach.
>> >
>> >> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDAL=
ONE)
>> >> which the back-end can advertise which allows a probe message to be
>> >> sent to get all the details QEMU needs to know in one message.
>> >
>> > The reason we do piecemeal is that these existing pieces can be reused
>> > as others evolve or fall by wayside.
>>=20
>> Sure I have no objection in principle but we then turn code like:
>>=20
>>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STAN=
DALONE)) {
>>             err =3D vhost_user_get_backend_specs(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_specs =
failed");
>>                 return -EPROTO;
>>             }
>>         }
>>=20
>> to
>>=20
>>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_ID) =
&&
>>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_CFGS=
Z) &&
>>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MINV=
Q) &&
>>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MAXV=
Q)
>>         ) {
>>             err =3D vhost_user_get_virtio_id(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_id fai=
led");
>>                 return -EPROTO;
>>             }
>>             err =3D vhost_user_get_virtio_cfgsz(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_cfgsz =
failed");
>>                 return -EPROTO;
>>             }
>>             err =3D vhost_user_get_virtio_minvq(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_minvq =
failed");
>>                 return -EPROTO;
>>             }
>>             err =3D vhost_user_get_virtio_maxvq(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_maxvq =
failed");
>>                 return -EPROTO;
>>             }
>>             dev->specs.valid =3D true;
>>         }
>>=20
>> for little gain IMHO.
>>
>> > For example, I can think of instances where you want to connect
>> > specifically to e.g. networking backend, and specify it
>> > on command line. Reasons could be many, e.g. for debugging,
>> > or to prevent connecting to wrong device on wrong channel
>> > (kind of like type safety).
>>=20
>> I don't quite follow what you are trying to say here.
>
> That some or all of these might be better on qemu command line
> not come from backend. Then we'll want to *send* it to backend.
> All this at our discretion without protocol changes.

That doesn't solve the standalone problem though (not all VMM's are QEMU
after all). I'm currently putting together a PoC with the
vhost-user-device and I was intending:

 - no CLI args, probe and if nothing fail
 - CLI args, probe with no response, continue with CLI args
 - CLI args, probe with response, check args match (or in bounds for
   vqs) and fail if not

Stefan wasn't super keen on the vhost-user-device in v2 being user
creatable because things could go weird quite quickly in hard to debug
ways:

  Message-Id: <20230418162140.373219-1-alex.bennee@linaro.org>
  Date: Tue, 18 Apr 2023 17:21:27 +0100
  Subject: [PATCH v2 00/13] virtio: add vhost-user-generic and reduce copy =
and paste
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

However it certainly is useful from a development point of view being
able to plug in new VirtIO backends without having to copy and paste
another slightly different stub into QEMU. I was pondering a middle
ground of maybe making the CLI options all x- variants to emphasise the
"here be dragons please know what you are doing" aspect of them.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

