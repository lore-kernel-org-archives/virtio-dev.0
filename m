Return-Path: <virtio-dev-return-11919-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815BFC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:31:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D3D9C2ACA1
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:31:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDB85986418
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:31:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C23099863E4; Mon,  3 Apr 2023 17:31:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A71F59863DE
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 17:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qIkMyIQyOGe1JP1kqfQG7A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYNdE1bp0wMahUWDGuWMpmhebl+7W/n5ojibxHT40NI=;
        b=oD4t3I0uNZhdil4mOLUN9ayLBbgCfREoayftRDpaAVkKNDPPF9aYWhhtwzMCLMSgUP
         ijYc43J4mZrNmqpElHDmYtqgSqgPdPLrc5E/l5PDIhcJtisWpnLmALMqxyB1i3iA6c3j
         T9TuLGxsqrxN3DycIS4WITSnMp/68qLri+YruCSole0Z5h2o/Xr3Zzq0/lQvZOfweS5k
         c1ILhx0mQnK1bqzDefOCwu4Qs9D2MKfeDXsVUvxMFUo0B75mNhehtAb64R3u5XxSBkpC
         V+1kYK7yhAxVzINUyQvv0ROCYLgmlOUWyf+p/QA4Qz8mrdCMRboXVeKLQ4P/p1c4oxrh
         zgIQ==
X-Gm-Message-State: AAQBX9dOb6Ucx6lWm6i/0YRDfqkELym8PsdeHOCoeU8/q/Z2Q+F5Jbri
	CBuw0dza8eaHi6BXApHJ8U/SHOPryrWXzm40BNKWARyoGIkmA0ksYN3Kz8uSJHoQrfd6M0aBqW4
	0h3HhtSeGy1sRnsNnq29NO19oX1bk
X-Received: by 2002:a17:906:85c2:b0:88d:ba89:1837 with SMTP id i2-20020a17090685c200b0088dba891837mr18129990ejy.8.1680543098628;
        Mon, 03 Apr 2023 10:31:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZDGrzgX+eyzhPqXjz4yGPIisLmIIQXXTykuMh7J+8izNpXaXLVTX0TBfe0+b3hGrgn+XGxXA==
X-Received: by 2002:a17:906:85c2:b0:88d:ba89:1837 with SMTP id i2-20020a17090685c200b0088dba891837mr18129965ejy.8.1680543098330;
        Mon, 03 Apr 2023 10:31:38 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:31:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230403133022-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <87pm8kly33.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87pm8kly33.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 00/10] Introduce device group and device management

On Mon, Apr 03, 2023 at 06:39:12PM +0200, Cornelia Huck wrote:
> On Mon, Apr 03 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Change log:
> >
> > since v10:
> > 	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
> > 	Cornelia, do you want to pick up 10/10 separately?
> 
> I'm not sure that makes sense -- if we refactor to introduce a patch
> that deals with all of the currently unimplemented features (and respin
> this series with the patch that lists the admin vq as unsupported on
> top) we could do that, but I don't think it's worth the effort.

My concern is that people are already kind of familiar with the
patchset, reshuffling for no end result will cause everyone to re-read.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

