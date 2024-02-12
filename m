Return-Path: <virtio-dev-return-14298-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFF8C48297
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Feb 2024 08:48:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1899D2AEDE
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Feb 2024 08:48:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0BA99863A9
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Feb 2024 08:48:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C42FF986326; Mon, 12 Feb 2024 08:48:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1A4198633E
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Feb 2024 08:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727694; x=1708332494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oni3uFKGBx/Bf7ZxOl75AgFWO+C4+hLj1OQZyxvedMo=;
        b=AoT6llPQgVfxpVkyTDOyrxnxvw6dBi7PgraY9ZbcM31ZC8K1RZ7PLofWPKb4F68UAM
         bTQiNJM3I5tnS1ZC/PuJV3zOUoFkRZmkCA4IDb0RrqdGKv/GqBe+I4f1/JS5xQLpGxvh
         egf1KJZq/nseFJyEG8hkhcZ0BPh0ikb1GlgVW+O8/AvSsprUo1DNitv+I/p74rvwudxn
         FNiDk/cqRlYiUBwK9HTTLIYc2PQuNh4h4/1cC5O8VYoGHXhEm2VxzDXPoLbQgTtLoh/J
         D7L5gWhMHLiA/rb8KkG3o2N2fUHp9tXCNygu7sfHJi4V8a7B9FF8Gpa7SxcOnVsbF8ar
         ub+g==
X-Gm-Message-State: AOJu0YzErnWuxwudO6dFGQigIZSI2un8bL5FrQ8YCAUHtKYl/jGYpXao
	hVWDxeAV5wB6owXnG87pZcak5R/9fxGqhcu3Mpu8NqxPEsXNQ0/pEztpLRjuLzQkDZool+sNLUN
	D
X-Google-Smtp-Source: AGHT+IEaqX9lOSX332ry1j4uULSNsql8F67IrdAE4wdo8df6+ZF2xMn3VSeNZoFCo6NszDbdCgGmpw==
X-Received: by 2002:a17:90a:8a0c:b0:297:cdf:ea3a with SMTP id w12-20020a17090a8a0c00b002970cdfea3amr2867105pjn.2.1707727694327;
        Mon, 12 Feb 2024 00:48:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNMsG/W1NpwlhPxNPGeWDQAOiu2T7a3LMPvWffiVLQuQmi5cKM4A3pypbsZdPIgXw3U0Acup1oWdLMO3SLHgxaLuTmCdRveG2/tNlrb89trcrYWylmpGHq7vpN2baKgFovOjs9PBVTlE/e6MAY3+NH+pnciVyChB/DCIfWTfCb4KiPe+LpPuk0mJIhZvIvyGhgaU6ctE8lyse7Hfxc3L6BqYiJ4w5KCh28xKfZ/Wn7QSbfN2S26S8fg/ADvHPHninI9pw=
Date: Mon, 12 Feb 2024 14:18:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240212084811.fxxv4w2plwepaeuw@vireshk-i7>
References: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
Subject: [virtio-dev] Re: [PATCH V2] virtio-transport: Clarify requirements

On 30-01-24, 13:58, Viresh Kumar wrote:
> The virtio documentation currently doesn't define any generic
> requirements that are applicable to all transports. They can be useful
> while adding support for a new transport.
> 
> This commit tries to define the same.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Lot of changes after discussions with Alex and Cornelia.
> - Almost a rewrite of the first commit.
> - Add Transport normative sections.

Ping.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

