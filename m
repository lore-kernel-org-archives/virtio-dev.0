Return-Path: <virtio-dev-return-12058-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE1BC6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:30:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A0CE22AD40
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:30:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DD359865E3
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:30:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 663689865D7; Fri,  7 Apr 2023 11:30:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 54CB09865D8
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 11:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Dw3XiwldMAyLzGWhlx9wiA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M9aDevLK6f8mrN5BW5NaPFjc/AGpQSIZoGe9bCUFxU=;
        b=reFgTlIjFYmj1SEXYHlQ3SNUxOKGSdpkvkA1kMLx2pEpo6O9BjuXmXzOQK/BviY7fj
         url1gjAG/LsaXmBkbFZ4q3zQKydkUGhrGsNzqymMvsxOddOdxicg4Xgj12WsKGCpKkj2
         uJAEd0veFEo7DSwm2OY1tyN+xoYBPAl1VnqTsdQUN95KnU+lnkH3iDwc66H1btt+TgYV
         VJAcJABcfrEKQF+GlzpcXqaAAT6AtsGekqWCjwwnKn8Y4RXJBpCuMa/ATITDqAN+tMGL
         0JHZLojtkWBdGMfVlJ7D9XMLFDgbac7f50NQgmzGEbq4Lj6TAK8IehKSNyEOYmd51mQy
         ofXw==
X-Gm-Message-State: AAQBX9daHUdcZxEtR5+WxUGQkieid+BPuWhMQj+HV2kyHbHvJ4AdA7ci
	RMkqUiPu635p48Ow2XwlQxxuqKcx7WKo5AnAA83e1IYV75jhHOP+t2ilIrW3Mn5iPujppK6ZWcI
	40BKNNSjKVuMeQa/YFvGbFNwgdZ/0
X-Received: by 2002:a5d:5919:0:b0:2ca:8da1:db96 with SMTP id v25-20020a5d5919000000b002ca8da1db96mr1016608wrd.50.1680867015158;
        Fri, 07 Apr 2023 04:30:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yr6P0E2Qyc/SZfk80zOH3uZbSbWgxR8UMNtkQqzN1qcKIcT4RAuQ/VekD6pk5RXjO3BhPbxw==
X-Received: by 2002:a5d:5919:0:b0:2ca:8da1:db96 with SMTP id v25-20020a5d5919000000b002ca8da1db96mr1016587wrd.50.1680867014894;
        Fri, 07 Apr 2023 04:30:14 -0700 (PDT)
Date: Fri, 7 Apr 2023 07:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230407072815-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-2-parav@nvidia.com>
 <20230405051801-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810141129464569ECCC825DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810141129464569ECCC825DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] RE: [PATCH v12 01/10] content: Add vq index text

On Wed, Apr 05, 2023 at 01:03:29PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 5, 2023 5:19 AM
> > 
> > In fact can we just say "virtqueue index" everywhere? The less slang reader has
> > to learn, the better.
> 
> Wow, didn't know that "vq" is a slang. :)

And so is "virtqueue".  It is certainly not in my dictionary of standard english.
One term to learn is enough I think.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

