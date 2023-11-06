Return-Path: <virtio-dev-return-14041-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2A9C4332F
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Nov 2023 15:09:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2094072350
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Nov 2023 15:09:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED4409867B2
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Nov 2023 15:09:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D081A98672B; Mon,  6 Nov 2023 15:09:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD3C198672D
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Nov 2023 15:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Oz9SrIHWOt29XyL_x-61Iw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283354; x=1699888154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSPsRtYlr3jJKw79cqYXnCKa9byqR3YfONwJbPCoQGQ=;
        b=SqKVo6SLU1YmKldlibNljdY7a/38PZX8LnACffNmFpILwQJGvceESE+Vu1GzXLY6m1
         LSqNzslGOgcP/LNiKXwiel7tFpPWuJ6xsAtmDC/UB/QRDd483Rqph7skQoaf3NnpfebD
         zjadY9wXMuIjdZfvt/+m9alGkXH+l325n73d8HPz2/C5w1GVQlvh6iGnUGxanFB9RE8c
         F4tgrp0uo3BP0rXjhALrLaoUZJ89JaJaPHHv1WLwKJhke/thcSPPl2pO/XB34mfxPCjb
         S9kmAmW9X0gj2M2jze0CHD2tKB99euetNjaZAioLKQsTTeaQP4emZbfnT8zNZDD2iFVe
         1BHg==
X-Gm-Message-State: AOJu0Yz3ZYLJ1G2XvGEh+Lar3zez0mZIxY+LJ7ghSHcepHUoxu0KqPYP
	zY9CSdZ37xZFCeboNwuRJOs/muME7muBsfUrEI6hi1qvvdEK0xWoLjyAXiid14lLcDC1nJGdLsa
	Gee4yIil5snC5o8L/9KuaYssah7xwOv5kW7STvmmWz2mB
X-Received: by 2002:a67:b20b:0:b0:45d:b4ad:ec78 with SMTP id b11-20020a67b20b000000b0045db4adec78mr5119363vsf.31.1699283352960;
        Mon, 06 Nov 2023 07:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6dEXJwKSkCbONV7jAXOiTfIwsKI285l/P5JbB6fURpUiIbc3w5hlCZ3MFUs8avey2raTio8tvmhqR2LGfzD4=
X-Received: by 2002:a67:b20b:0:b0:45d:b4ad:ec78 with SMTP id
 b11-20020a67b20b000000b0045db4adec78mr5119345vsf.31.1699283352655; Mon, 06
 Nov 2023 07:09:12 -0800 (PST)
MIME-Version: 1.0
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTeZ6YjyR0BJOylw@fedora> <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
In-Reply-To: <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Mon, 6 Nov 2023 16:09:01 +0100
Message-ID: <CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com>
To: Radu Ocica <rocica@blackberry.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] virtio-snd comments/questions

Hello,

On Fri, Nov 03, 2023 at 07:05:30PM +0000, Radu Ocica wrote:
> Hi Matias,
>
>
> I will answer to your comments:
>
>
> > I agree that the STOP command could be better explain it. In our
> implementation[1], we implemented as your last point defines it, i.e.,
> stop host's pcm stream and keep messages in tx/rx. The STOP control
> command is marked as completed immediately. The virtio spec does not
> indicate that STOP requires to mark pending io messages as completed
> thus we do not do that. A note about this in the spec would help.
>
>
> In our implementation we made the assumption that STOP is meant to be imp=
lemented as pause, thus if the host stream supports the pause operation we =
pause it and keep io messages in tx/rx queue; the host stream is stopped (v=
ia the drop operation) and io messages are marked in this case as completed=
 and returned to the guest driver only when receiving the RELEASE control r=
equest.
>
> However, if the host stream does not support pause the only option left i=
s to perform a drop operation on the host stream and in this case all pendi=
ng messages in the tx/rx queue need to be returned to the guest as complete=
d, because at the next start possibly all messages will be needed to prime =
the host stream (in the case of playback). A host stream prepare will also =
be needed to be issued internally by the device if a START is issued by the=
 guest right after the STOP. And there is some uncertainty whether a guest =
driver will send new io messages before or after the START control request.
>

Could you elaborate on this? Which audio backend would not support
PAUSE? I am not very familiar with audio engines.


> I think the difficulty of describing a clear behavior for STOP stems from=
 attempting a minimal spec, with a minimal number of control requests. If d=
edicated STOP vs PAUSE requests were used, it would be more straightforward=
 to specify an unambiguous behavior for each.
>
>
> > Checking the Linux kernel driver, the STOP cmd is issued when getting
> SNDRV_PCM_TRIGGER_PAUSE_PUSH. Documentation does not indicate when this
> msg is sent though. The RELEASE cmd is issued only during
> virtsnd_pcm_sync_stop(). In this sense, I would guess that STOP behaves
> like a PAUSE whereas RELEASE behaves like a STOP and dropping all
> pending IO messages. The spec left for the implementation if device
> would still playback those buffer or just drop them. I think you may
> find interesting the discussion we started at this thread[2] regarding
> the RELEASE control cmd semantics.
>
>
> We have made the call to never have the device drain the host pcm stream.=
 If the host pcm stream supports pause, then STOP pauses it and RELEASE per=
forms a drop and returns immediately all io messages as completed to the gu=
est driver. If the host pcm stream does not support pause, then STOP result=
s in a drop operation and return of all io messages as completed to the gue=
st driver, and the RELEASE is a no-op. A drain like behavior for playback c=
an be obtained if the guest driver stops writing new data and waits to unde=
rrun, time at which it sends STOP and RELEASE. This seems to work fine with=
 the existing reference linux/android guest driver for success path handlin=
g. There are questions regarding failure path handling (failure of control =
or io requests) and what variability can/should be expected in terms of gue=
st driver behavior.
>
>
> > Right, we discussed about this issue at [3]. I've recently proposed the
> following patch to fix that: '[PATCH v3] ALSA: virtio: use ack callback'
>
>
> This looks promising. I found it already at https://github.com/torvalds/l=
inux/blob/master/sound/virtio/ and will give it a try. Is there a repositor=
y for this driver code where both this fix and the audio control support is=
 available?
>
>

What do you mean with audio control support? Are you talking about the
device? The device implementation is at
https://github.com/rust-vmm/vhost-device/tree/main/staging.


Matias


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

