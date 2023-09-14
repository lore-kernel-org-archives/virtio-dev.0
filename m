Return-Path: <virtio-dev-return-13762-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68C7EDE9A5
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:14:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BC888217DD
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:14:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72B51986662
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:14:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5EE0698402B; Thu, 14 Sep 2023 11:14:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EA549866FA
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 11:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bhGsBzr8ONCwqCGIvtDXHQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690055; x=1695294855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc1eUKQLa9Cze03rndv7eWZSRr3HGJWwe1nNn2bcdgA=;
        b=rxNeJeIq3PK3OE+/V7mKJyC3myQb+Fk5CFVQutpHLstBHZfeeGiSVxZZKHi6kppzmE
         3/t7m5Asbqz7wImL8zYWecBLxMwHdZ30SoWPfgfgUlwqu2ifoL9t6tPFgsx7zo7xZrZD
         5uD9RaEj3T+HFX3BJHzGO1JyN/QyotvdHHxbxju8zfxKsleyrmaRZ01M9ZsF9qOO4xF0
         j/Y7FcfDS6lOh74tni5XKNQ4xtHW5pJiy5obauvf3LqNwVopyca2RfIE89cSP+tQKcmY
         pFLniRq2GRv5JrTiOW/xXQK/qzNiVosY67uMcIjgHbuDwHkTupwgdpd0ZUEUD7hKLXPz
         QXWw==
X-Gm-Message-State: AOJu0YzJNbZ+PhjNbLid1CnPqFj6GWw+eDCEkgk29eI6lI1EyGB+whGo
	hu/CBYYkOtwNJ8ER2rFHpvny5nb10wABA4vbAHiBpiz7Rf+9Ce3FEtyI9meJRYGAMPIO803Jf0w
	RXY6nY8lcCaf2puDaJwPcXwFMiJfh
X-Received: by 2002:a50:ee06:0:b0:523:c36e:ec8b with SMTP id g6-20020a50ee06000000b00523c36eec8bmr2042393eds.9.1694690055701;
        Thu, 14 Sep 2023 04:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT5HaO5uZaQLhoD3VH8SZhwphYjnm9jRe0MMeuEByX8uCJvzumlDP4A8Pm73YzMo2qOxtNWw==
X-Received: by 2002:a50:ee06:0:b0:523:c36e:ec8b with SMTP id g6-20020a50ee06000000b00523c36eec8bmr2042372eds.9.1694690055342;
        Thu, 14 Sep 2023 04:14:15 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:14:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230914070911-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
> This series introduces
> 1)a new SUSPEND bit in the device status
> Which is used to suspend the device, so that the device states
> and virtqueue states are stabilized.
> 
> 2)virtqueue state and its accessor, to get and set last_avail_idx
> and last_used_idx of virtqueues.
> 
> The main usecase of these new facilities is Live Migration.
> 
> Future work: dirty page tracking and in-flight descriptors.
> This series addresses many comments from Jason, Stefan and Eugenio
> from RFC series.

Compared to Parav's patchset this is much less functional.

Assuming that one goes in, can't we add ability to submit
admin commands through MMIO on the device itself and be done with it?

> Zhu Lingshan (5):
>   virtio: introduce vq state as basic facility
>   virtio: introduce SUSPEND bit in device status
>   virtqueue: constraints for virtqueue state
>   virtqueue: ignore resetting vqs when SUSPEND
>   virtio-pci: implement VIRTIO_F_QUEUE_STATE
> 
>  content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>  transport-pci.tex |  18 +++++++
>  2 files changed, 136 insertions(+)
> 
> -- 
> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

