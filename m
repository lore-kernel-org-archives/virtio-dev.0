Return-Path: <virtio-dev-return-12970-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A5DEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08BB97A068
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB3CF9863B0
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:05:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BDFE09863A6; Mon, 19 Jun 2023 17:05:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 439B39863A9
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 17:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HMMDT-6MMe6aNN0YsHnTpA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194270; x=1689786270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czaTvAL0283TaAk9AfUuCB/ugeyobeCgMeg00EZeZr0=;
        b=KhC7LrvHHqnb/baQReSX/PMwolHvf6Y+wHdSp340gapKr0mmmHmEoonrVTwKNtN5x9
         +j5W3tLuYQBcLE6oUm58q4V/N/SqS73HyclF/CMO8CANxQQ8xllcbcX8khTcmMMZpTHn
         6j9xzfbYCsiQffRVMEcaeQV8iUCCCn/66TOBuyPtqNfsua6nlkCSH3qkjbpDVlWuQTU0
         u6RR4XGF0h2ufV14LWbwMcE2Wy3YDeLLeM8CCshEOeb56wMZlm0/weQN7UkgNetlP2R6
         xG6vRuNNRbfE579sT/0LDZ9r/V/TGzgN153aqAs8ch/9+83u9e2kLwVpIR6SXtJ1xHey
         65yw==
X-Gm-Message-State: AC+VfDzRodALG28a8/i38Yw8mWShSrwmBCTUcCpfUQuqiwiHGByD3L+o
	fNZZEVhHVhuGDHoobk+oniJmdSBPua5KDni8ODiS4cYh0zEvR6C0zPRwnOCy/8mOfMBlw/uOFUY
	aeNPOzNclSnE3F3lvDJFPFUzpZrVU
X-Received: by 2002:a05:600c:248:b0:3f9:b3b4:4367 with SMTP id 8-20020a05600c024800b003f9b3b44367mr1376187wmj.15.1687194269881;
        Mon, 19 Jun 2023 10:04:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lNrtoUnzKhnIIBbkeiMwRaj1Y0+EZdIOgHHcS3ZWt9f+Rvwp/bY4VMMCowuTCAg+ao07luA==
X-Received: by 2002:a05:600c:248:b0:3f9:b3b4:4367 with SMTP id 8-20020a05600c024800b003f9b3b44367mr1376166wmj.15.1687194269580;
        Mon, 19 Jun 2023 10:04:29 -0700 (PDT)
Date: Mon, 19 Jun 2023 13:04:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230619124042-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230613173015.1244486-5-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access

On Tue, Jun 13, 2023 at 08:30:15PM +0300, Parav Pandit wrote:
> +Even though virtqueue driver notifications can be communicated through
> +administration virtqueue, if the group member device support such
> +notifications using a memory-mapped operation, such driver notifications
> +are sent using a group member device defined notification region.

I still feel we should support sending notifications to owner
at least optionally. For example:


\begin{lstlisting}
struct virtio_pci_owner_legacy_notify_cap {
        struct virtio_pci_cap cap;
        le32 notify_off_multiplier; /* Multiplier for member id. */
};
\end{lstlisting}

\field{notify_off_multiplier} is combined with the \field{member id} to
derive an address within a BAR.

\begin{lstlisting}
        cap.offset + member_id * notify_off_multiplier
\end{lstlisting}



We also need, as part of theory of operation, text that reads
something like "accessing the member device legacy interface
using one of XYZ commands has the same effect as accessing
it using the legacy interface".



Also, do all VFs support legacy interface with these
commands or none at all?


Also these devices will use non-transitional ID but they in fact
do have a legacy interface so using this definition they are
transitional devices. Maybe we need to add
when we describe the device ID text like "non transitional
devices and transitional devices utilizing commands XYZ" ...?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

