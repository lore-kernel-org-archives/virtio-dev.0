Return-Path: <virtio-dev-return-14042-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EEEC4167D
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Nov 2023 15:18:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EEEC626A5A
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Nov 2023 15:18:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7CC99867BB
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Nov 2023 15:18:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C070298672E; Mon,  6 Nov 2023 15:18:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE92198672B
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Nov 2023 15:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _yHFFbCzNNGXbekJPFvrQQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283915; x=1699888715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUanjZZsy32CFqQmlle45mgmRhClCW/tNDasx5Dnigg=;
        b=LgF2jGh0K3tQE7Df16nm/mWehceja97pr5omHYnC5rvNNZiBLrMUDlNQqceLypwjf/
         3x8F+7mMOweiJ00/FuWtXX5TWZNckCJ3joyk9ZuzO1BYBNPNDcPzKXbd/KOMMSal2EzE
         0Xnv0ZpuOUilvKnKAV0WWASqp+poCCrOpAPwulfZB9bjYwAhChXBUP6L7uW0WgoMx3kP
         7FlaXr0tr/TxN9l4/0q2KgqtjQFD7llhIJQdQFslQ6UNwLhyoW4DkZLSCPmJrZpiirPd
         klgYa80Pi6x0SELzCdFSD5ba7hg0SP6sSaYTYkV2s5TyBP1qau9oGsQ0EpGazwbV15Ia
         qDCA==
X-Gm-Message-State: AOJu0YxQvrQ9EX9z3qELmfKVT/Dkj1al/kAphiVYgVIE1fzo/+JiRAFj
	j9OpteQIy1jCxY/txrPKqX9kj6AtDMzbRCznoNNMyWiiQC9ovb0hhAtUR19uBPyoiR6tQEtGMA2
	VY+/ipa0S1z6kI9QvRGYwt8drroBz42jmeKYJQQ+gwrItTWu6cAEc
X-Received: by 2002:a67:c115:0:b0:45f:dd0:e1aa with SMTP id d21-20020a67c115000000b0045f0dd0e1aamr3940314vsj.31.1699283913378;
        Mon, 06 Nov 2023 07:18:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6mXxo8jvWylFOaOFq+qLxWTdag/r4aq6+b13LQ0y51GJ7sLpgFFuDHBaWapRMw/a5/7d0TxXSHI/1/58NCiU=
X-Received: by 2002:a67:c115:0:b0:45f:dd0:e1aa with SMTP id
 d21-20020a67c115000000b0045f0dd0e1aamr3940275vsj.31.1699283912813; Mon, 06
 Nov 2023 07:18:32 -0800 (PST)
MIME-Version: 1.0
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTfHAQxns6j8gmEL@fedora> <134bb8dbb49643e6b3d6e9b65239b6a8@blackberry.com>
In-Reply-To: <134bb8dbb49643e6b3d6e9b65239b6a8@blackberry.com>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Mon, 6 Nov 2023 16:18:21 +0100
Message-ID: <CAHYGQ0whtt3pUK+dqrCFpRP4zJTV+6kXt4S3VG-WAM+ROV5N3w@mail.gmail.com>
To: Radu Ocica <rocica@blackberry.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] virtio-snd comments/questions

On Fri, Nov 03, 2023 at 06:17:17PM +0000, Radu Ocica wrote:
> I also think that the driver should not send a STOP command after a faile=
d START command. There is no explicit description of any states in the virt=
io sound device specification. We have both adopted an interpretation that =
the state is determined by the last successful pcm control request and the =
transitions specified for pcm control requests assume success of these cont=
rol requests. I wish this was clarified explicitly in the spec, to not allo=
w room for interpretation.
>
>
I agree. I think what is missed in the spec is to define the behavior of
the PCM command cycle in case a command fails. I worked on a RFC to
improve that section, feel free to comment at
https://lists.oasis-open.org/archives/virtio-comment/202307/msg00158.html.
I think an overall solution would be to implement the PCM state machine
in the driver thus control messages would be sent only if the stream is
in the correct state.

Matias


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

