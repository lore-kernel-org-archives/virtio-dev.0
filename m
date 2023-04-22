Return-Path: <virtio-dev-return-12347-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE395C77B78
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Apr 2023 10:10:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 39A622B341
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Apr 2023 10:10:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F1BF98663C
	for <virtio-dev@archiver.kernel.org>; Sat, 22 Apr 2023 10:10:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1FBFF986641; Sat, 22 Apr 2023 10:10:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06F1B986640
	for <virtio-dev@lists.oasis-open.org>; Sat, 22 Apr 2023 10:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fZGgiaMpMV67q5PT0HrKpw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682158236; x=1684750236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha1yXeR1JeO/eaD0mkP+Ru0vVbQGZGMRQN97Gj9QuTI=;
        b=GsHYX3g7VyaX/tXgwfp3i6YX9io3hK52f5A9EUm70PQT6YZqsT/qj9HWjxaoNV1t+1
         pwZeaSxmo9CvWoLxtj4G/+WUap1sq62TNG4m3E02+lD/5GJTACrJV42wMmn8uq5k6jON
         V8PAzU1noqc2OUZt4S9yWv7meiuRPebEO4z7LawBk1FjQp0l1qspoE7xCg3H5TdaHZDq
         FG2G+V9zBKjrIwlWtTt2eVFFGZRVUTR+dQn1CaCy6/Mra16diBrhQPnl8121LRidIHcS
         9GpHtCRZhiWUVD9rjo+5nkLxQLXaYQpsDjI3v5WhC41alBWr1cxlHFoZM95UcTptwbcs
         Oilw==
X-Gm-Message-State: AAQBX9e53lFDPLdQKKquiGEGjaurlVB1daL0it0VdBQs9qSNMz2riwtR
	7m2fesv+/CyRFzzbJN2FCe2IW8ERRzWKa8/sqIk/v492Q33gAEtbTbhHDhankUgwR7DH8Wp/kC8
	Tpw5aApuFGzKIANO64x+IB7cIURNn
X-Received: by 2002:a5d:6782:0:b0:2fe:c0ea:18b5 with SMTP id v2-20020a5d6782000000b002fec0ea18b5mr5001681wru.35.1682158236163;
        Sat, 22 Apr 2023 03:10:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZE4G6PnY5ME3PjSwI4k6xg4ZSuWaBaeGtOnAeKHPCNjpwfdg2ok5A0DwH8CCRvd23qcu/wCw==
X-Received: by 2002:a5d:6782:0:b0:2fe:c0ea:18b5 with SMTP id v2-20020a5d6782000000b002fec0ea18b5mr5001672wru.35.1682158235831;
        Sat, 22 Apr 2023 03:10:35 -0700 (PDT)
Date: Sat, 22 Apr 2023 06:10:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230422061011-mutt-send-email-mst@kernel.org>
References: <20230421145434.83774-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230421145434.83774-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/2] transport-pci: msix register desc improve

On Fri, Apr 21, 2023 at 05:54:32PM +0300, Parav Pandit wrote:
> Problem:
> 
> Current wording queue_msix_vector and config_msix_vector says
> "for MSI-X", which is bit confusing.
> 
> config_msix_vector and queue_msix_vector are the msix vector
> number for configuration change and queue related interrupts.
> 
> Hence, reword it.

LGTM.
Given the amount of back and forth, I guess we should vote.

> ---
> changelog:
> v2->v3:
> - reword
> v1->v2:
> - rewrote to indicate MSI-X table entry index
> v0->v1:
> - added 'here'
> - dropped 'receiving'
> - dropped already merged patch for empty line
> 
> 
> Parav Pandit (2):
>   transport-pci: Improve config msix vector description
>   transport-pci: Improve queue msix vector register desc
> 
>  transport-pci.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

