Return-Path: <virtio-dev-return-14307-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6978BC4829A
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 14:58:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 985CC335C1
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 14:58:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6553B98658D
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 14:58:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B85E98649D; Tue, 13 Feb 2024 14:58:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29DC89864F3
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Feb 2024 14:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: THNjI6P7PUyHP4SwJWCnVg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>, Mikhail Golubev-Ciuchea
 <Mikhail.Golubev-Ciuchea@opensynergy.com>
In-Reply-To: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 13 Feb 2024 15:57:59 +0100
Message-ID: <877cj8h0nc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Subject: Re: [virtio-dev] [RFC PATCH v3] virtio-can: Device specification.

On Fri, Jun 09 2023, Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:

> diff --git a/introduction.tex b/introduction.tex
> index b7155bf..d560c63 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -101,6 +101,8 @@ \section{Normative References}\label{sec:Normative References}
>  	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> +	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\

Just noticed while massaging this patch to apply on top of the 1.4
branch: This reference does not include an url; I guess
https://www.iso.org/standard/63648.html would be the place to point to?

(This can easily be added via an editorial update on top.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

