Return-Path: <virtio-dev-return-14292-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCACC46CD2
	for <virtio-dev@archiver.kernel.org>; Tue, 30 Jan 2024 11:29:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E9B9E2A8E2
	for <virtio-dev@archiver.kernel.org>; Tue, 30 Jan 2024 11:29:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDE9C986882
	for <virtio-dev@archiver.kernel.org>; Tue, 30 Jan 2024 11:29:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3171983F76; Tue, 30 Jan 2024 11:29:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5934986876
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Jan 2024 11:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614140; x=1707218940;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AbV8/NRVQABs1ysdhyvrixKfug6y0yz2+3UtJi/l7E4=;
        b=mZuBKsyuNQa9l/tX9dhebmD9BkoMULSZSbweUR42ox2l+Dr1+uDfITsYIZbXsRwvBT
         x/u6uzZX+MKr9DvvBEgt/9NpeadThyL+8W+JEYTGly+G4Gy+zRYneYTVm5Rfn1A0N7We
         15nefB0mvki1AP0Eht6if7fOT2kPCItkAesy2bhDeetIAUvZfrwzd35vXRF2bmD12g7U
         gBRy/IAnHIxgPssuPpod2XuPz9ceX+VJCZG8U0vqw+XwuAH/5yB9YXen9xOIvDD0XXA5
         p0bflTBexTIdggql1PuHaPatDS6cipasNPiLg6YXhNCPz8wnSyL8Wrg+6KejZVd2XTgO
         bJVA==
X-Gm-Message-State: AOJu0YxY4Fmyhagd1FO1+jtCJ6Ve3NxrEL4n01SspJcxY7Lw7CrrD2kf
	ciPstXgm7XMI0WdE+KWADA4H+AdcAwCHPy4pD2shY72HDlJ3a42/+5YgoB5HpUY=
X-Google-Smtp-Source: AGHT+IEnkmP67LjF5dwdQYYwLmDzyMTEnLsTjnCQjXU1dKQm0KFsVyhBxBbBBm94SjhhBmTTIgQAKg==
X-Received: by 2002:a5d:4401:0:b0:337:a5a9:92e1 with SMTP id z1-20020a5d4401000000b00337a5a992e1mr6520457wrq.33.1706614140662;
        Tue, 30 Jan 2024 03:29:00 -0800 (PST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-dev@lists.oasis-open.org,  Cornelia Huck <cohuck@redhat.com>,
  "Michael S. Tsirkin" <mst@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  stratos-dev@op-lists.linaro.org,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>
In-Reply-To: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
	(Viresh Kumar's message of "Tue, 30 Jan 2024 13:58:35 +0530")
References: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 11:28:59 +0000
Message-ID: <87o7d3oy9w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH V2] virtio-transport: Clarify requirements

Viresh Kumar <viresh.kumar@linaro.org> writes:

> The virtio documentation currently doesn't define any generic
> requirements that are applicable to all transports. They can be useful
> while adding support for a new transport.
>
> This commit tries to define the same.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

LGTM:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

