Return-Path: <virtio-dev-return-11889-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462C6C761A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:53:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 99E7F76F41
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:53:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9742B9863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:53:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D85F9863DD; Mon,  3 Apr 2023 14:53:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A7BE9863D6
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 14:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yYkKkCP2NNyCul5Tt56qBg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoKuATI9FxVQO65JzFGpn9MhU21ysHDKm1K9czzMNYg=;
        b=xD4+ZdOowHveMGISPxiaRjFB1zsExW7xaYitMSp26FeJT25QbfZ3A6ZOCszNNVQ00l
         PJkuQAqD8TiqfmmQxaW8vx2dhDYYSCpnMm8PpcVR4BwG/gBZzrvZa65iEQqpewRssLbb
         ovNDBhX6W3TkU6e6DJ4ihOYF7VWDoRY90Tg/g+obGSz62qjA3e6N8wFLFBH/LpyLnbE+
         2hp9S/GN+C02Y925wGyvubPjQgXI/AXwfaAeiBIS3XQN6C8mzJbLM+Iox4SRpeA/Mlq7
         HHxbyFm7CI/YUEUIogi4dx+6/s4Gikmkg0VbBRN8aJGiYCuMSmC7V3Lnl+rg9brquxrX
         Jexg==
X-Gm-Message-State: AAQBX9fI3jm8pAjmT3pNl4csKF+FA0kiRd1GBxQtMiQSM71pVxgPbC/e
	vZvFBS8DCyR84U7djdaMl8PDm50BKkeOdvN2oIjg9eYZL5zo4BEurK4l472vS8aOgWqc00uBc79
	NRO57tzYM7HESQt9mpkbEAQx6oFFj8bhdTgAr/EXRkQ==
X-Received: by 2002:a17:907:d68f:b0:92f:924b:e8f4 with SMTP id wf15-20020a170907d68f00b0092f924be8f4mr35220187ejc.4.1680533605002;
        Mon, 03 Apr 2023 07:53:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350ayLjEdhgpD+OvJ3wRofQa/ioptBciguqBLEuSy8clBRwFQdP5IyIadfMvcARXhoPXwrs2gsw==
X-Received: by 2002:a17:907:d68f:b0:92f:924b:e8f4 with SMTP id wf15-20020a170907d68f00b0092f924be8f4mr35220173ejc.4.1680533604745;
        Mon, 03 Apr 2023 07:53:24 -0700 (PDT)
Date: Mon, 3 Apr 2023 10:53:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230403105050-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Fri, Mar 31, 2023 at 05:43:11PM -0400, Parav Pandit wrote:
> > I can not say I thought about this
> > deeply so maybe there's some problem, or maybe it's a worse approach -
> > could you comment on this? It looks like this could be a smaller change,
> > but maybe it isn't? Did you consider this option?
> 
> We can possibly let both the options open for device vendors to implement.
> 
> Change wise transport VQ is fairly big addition for both hypervisor driver
> and also for the device.

OTOH it is presumably required for scalability anyway, no?
And presumably it can all be done in firmware ...
Is there actual hardware that can't implement transport vq
but is going to implement the mmr spec?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

