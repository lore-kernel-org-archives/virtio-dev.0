Return-Path: <virtio-dev-return-14309-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7101FC4829A
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 05:56:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC18876EC9
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 05:56:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D85449865A7
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 05:56:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBEE6986589; Wed, 14 Feb 2024 05:56:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE86D98658D
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 05:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890171; x=1708494971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlTbZOzj+/dcxN9qF+r1Rsexw2dPjOC01zr3Y5eMdkc=;
        b=t9RHahNDDzGATSV2woPnve3c9lZZ4jBTDes2ShZNR6IrAZrWKru4nbuaXvadA8ONLv
         uIOBaRH3/lIek0/RGDnUOX9pGvucyD4NoxI6mzgvcrj3yCcIAOPlGAqAmYyPJ6rvM51/
         7BQBSIwUSpzAYCYqSghUvPDZ5kIZcgxdjWR94Pxbhn/tcQ+LErcu9/oHG//XwEUTeSnY
         FIieWWYfVM8CXxEn6O4c9tJMUTq5hR2N2LeFGrgB2CH2VLRPjrD0hZ7EecduLr6UYu+B
         Pjtfq9XNILUoRXH+CWWTq876jkrk7mSRzYeqdjx/uimBieWqyjUgYjW65OQ9BMV2a5yP
         Az1Q==
X-Gm-Message-State: AOJu0Yxzp86CfTczt4GQr48eWJI/4PE0S2t+Pj56JfT8R6tod/UP3Dhq
	RUcdJ6KAvbe7OLOTJMjSyo2crYCSCoxjP2qhQdE6qXQ7G7wqAo7cWZCVwUQrhMY=
X-Google-Smtp-Source: AGHT+IEy9uZ6Jp2jG20RPfLTkCg7xTr0jF+3xzHOWjyEwJ7PQznB0tDb/A85HcTofmZHPbMqLhmF1A==
X-Received: by 2002:a17:90a:c246:b0:297:11a7:e789 with SMTP id d6-20020a17090ac24600b0029711a7e789mr1294895pjx.45.1707890171479;
        Tue, 13 Feb 2024 21:56:11 -0800 (PST)
Date: Wed, 14 Feb 2024 11:26:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240214055609.t3t3kv7mmxtcfkeh@vireshk-i7>
References: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
 <87a5o4h6v6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5o4h6v6.fsf@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2] virtio-transport: Clarify requirements

On 13-02-24, 13:43, Cornelia Huck wrote:
> Apart from the nits above, this looks good to me.
> 
> I'd be in favour of initiating a vote for this, after the OASIS
> infrastructure migragion has completed and we have dealt with any
> fallout from that... that would probably mean March :(

That's fine.

> (Oh, and this should probably go to virtio-comment as well.)

Resent now.

> [Apologies for not reviewing earlier, but I'm struggling to keep afloat,
> and the OASIS infrastructure saga did not exactly help...]

No issues :)

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

