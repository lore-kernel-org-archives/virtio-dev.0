Return-Path: <virtio-dev-return-13324-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D432EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 08:47:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 575E02B04C
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 08:47:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2EF9B986491
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 08:47:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1068D983FEA; Mon, 10 Jul 2023 08:47:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFF5B98640D
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jul 2023 08:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OOGnIwCQPLeL6nyqgqP9SQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, quic_ztu@quicinc.com,
 virtio-comment@lists.oasis-open.org, jrreinhart@google.com
In-Reply-To: <40e540f0-b07e-63af-d639-bcd71e4b23a1@quicinc.com>
Organization: Red Hat GmbH
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-2-quic_haixcui@quicinc.com>
 <20230630105606-mutt-send-email-mst@kernel.org>
 <40e540f0-b07e-63af-d639-bcd71e4b23a1@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 10 Jul 2023 10:47:35 +0200
Message-ID: <87sf9wywyg.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev][PATCH 1/2] virtio-spi: define the DEVICE ID for
 virtio SPI master

On Fri, Jul 07 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

> Hi Michael S. Tsirkin, Cornelia Huck,
>      I have created an issue 
> https://github.com/oasis-tcs/virtio-spec/issues/174 to request Device ID 
> 45 for SPI master. Please help to deal with it, thank you very much.

Technically, we're in feature freeze already, but practically, I don't
think we should block adding a simple device id reservation... Michael,
any objections to me creating a ballot later today?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

