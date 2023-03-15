Return-Path: <virtio-dev-return-11624-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF60C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 13:31:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 14C8641EEC
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 13:31:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EA8898641E
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 13:31:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04367986406; Wed, 15 Mar 2023 13:31:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8692986407
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 13:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yZw8PVaZM9Kyi7Ymylh6IQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: Haixu Cui <quic_haixcui@quicinc.com>, quic_ztu@quicinc.com
In-Reply-To: <20230227082329.31337-1-quic_haixcui@quicinc.com>
Organization: Red Hat GmbH
References: <20230227082329.31337-1-quic_haixcui@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 15 Mar 2023 14:31:38 +0100
Message-ID: <87h6umta2t.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] [PATCH] virtio-spi: add the device specification

On Mon, Feb 27 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

> virtio-spi is a virtual SPI master and it allows a guset to operate and
> use the physical SPI master controlled by the host.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  content.tex                             |   2 +
>  device-types/spi/description.tex        | 153 ++++++++++++++++++++++++
>  device-types/spi/device-conformance.tex |   7 ++
>  device-types/spi/driver-conformance.tex |   7 ++
>  4 files changed, 169 insertions(+)
>  create mode 100644 device-types/spi/description.tex
>  create mode 100644 device-types/spi/device-conformance.tex
>  create mode 100644 device-types/spi/driver-conformance.tex
>
> diff --git a/content.tex b/content.tex
> index 0c7cdf8..86bf709 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2994,6 +2994,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  44         &   ISM device \\
>  \hline
> +45         &   SPI Master \\

What is 'SPI'? 'Serial Peripheral Interface', I guess?

Introduction of the ID should be split out into a separate patch; if
people agree that this is a useful thing to add, please open a github
issue and request a vote.

> +\hline
>  \end{tabular}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

