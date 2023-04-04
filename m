Return-Path: <virtio-dev-return-11954-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FBCC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:07:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2F4EA1FF82
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:07:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E01498640A
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:07:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECE4F9863E4; Tue,  4 Apr 2023 07:07:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB43E9863E6
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 221QTrX9Mo2YEYWbW4wsDg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680592051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvU1MQxWBcitwvZcLcf2ltQ5T9q2zVggol0iKNTsiZ0=;
        b=0NcgmjKmj7+yD0Cd8fFWqJnmUXWgygyl28H1rdWkFmvRt3KGJwLGIwEA/S+onW5k25
         S0lLHOPHHteS4eKsIA54Uyjf/Z45v542iro8v7Wz/muB5g8UpmtxAa4ICnRmNAevAOO/
         asIY7/KWw5LE3gbizTQ35bYjOM0QVGYv1E+Kbla4+i8031Y8WZYNHQ+PeznEgJPT4kBN
         m/qnGrWXNikGoclJm8ComXLdgJRCMx3dl5durhUXN3RapwI/zT46VNfWEVjipJT/tNNG
         YIID/fZX8spyJQ1w3jmW8ItnCe+rhEWvDQeYOy7/HAJ6y/fhL/+Slu4ju8t5RvbF0wrD
         3BSA==
X-Gm-Message-State: AAQBX9cHtoCPWCt0D25fHUAG+ycNop0WHo1Uzg7o1s74LnNHmeu6zOow
	dNI5yRY5A0YrnB8qzxbBfpxaDuRpoBFGkvIu3VxFVLJJYTtM+bLcFdhwaVsxaGBjiFOfCtb9/1E
	saTTd38DN/8hcCSPtfJoNMMFa9vDp
X-Received: by 2002:a05:6402:337:b0:4fc:494a:98f5 with SMTP id q23-20020a056402033700b004fc494a98f5mr1519940edw.29.1680592050952;
        Tue, 04 Apr 2023 00:07:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350aGANzJsA81TI7x4QNJqbJwhMPfdI7D4EmGxgNrpe08/hCJYxVnJWg4InpeH5YugkBuj2c22w==
X-Received: by 2002:a05:6402:337:b0:4fc:494a:98f5 with SMTP id q23-20020a056402033700b004fc494a98f5mr1519923edw.29.1680592050700;
        Tue, 04 Apr 2023 00:07:30 -0700 (PDT)
Date: Tue, 4 Apr 2023 03:07:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230404030629-mutt-send-email-mst@kernel.org>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
 <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404033622.4b749f89.pasic@linux.ibm.com>
 <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Mon, Apr 03, 2023 at 10:57:35PM -0400, Parav Pandit wrote:
> 3. Once interrupt moderation series is merged, rename vqn to vq_index.
> (really vqn reads better even though history say vq index).
> Because votes is completed and voting period ended for the important
> feature.

interrupt moderation voting is still ongoing, isn't it?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

