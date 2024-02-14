Return-Path: <virtio-dev-return-14318-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DBAC48BC3
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 16:22:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DDBFD22382
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 16:22:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4DCF9865A4
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 16:22:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AA80298658F; Wed, 14 Feb 2024 16:22:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BEDE986590
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 16:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XxW0vQoiNEOUGy1KFytB7g-1
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
 Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>, Mikhail
 Golubev <Mikhail.Golubev@opensynergy.com>
In-Reply-To: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 14 Feb 2024 17:22:28 +0100
Message-ID: <87v86rf22j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Subject: Re: [virtio-dev] [RFC PATCH v3 0/3] Virtio SPI Linux driver
 compliant to draft spec V10

On Tue, Feb 13 2024, Harald Mommer <Harald.Mommer@opensynergy.com> wrote:

> This is the 3rd RFC version of a virtio SPI Linux driver which is
> intended to be compliant with the proposed virtio SPI draft
> specification V10.

FWIW: this version of the SPI spec has been voted in for virtio 1.4 (and
is consequently available on the virtio-1.4 branch of the virtio spec.)
For all intents and purposes, this makes this spec final (modulo
possible future extensions).


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

