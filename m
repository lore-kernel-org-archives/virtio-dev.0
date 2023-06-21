Return-Path: <virtio-dev-return-13019-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628FC0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:45:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1064094ACB
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:45:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3ED99865CF
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:45:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E48839865BA; Wed, 21 Jun 2023 19:45:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D370A9865C8
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 19:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: a-GrI6vWOrS8p48LI2VGEQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376721; x=1689968721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEI4KCDDyI3eztLKZfnSSvulBzZfTOdfhV/ovC+VLXQ=;
        b=e0PUsdlZg4behV7Q5dZBvNDIwlP3es0pkCjCgeE/gSEsxxGLR+FHgtwaVmjmYqgePk
         gMmNTav7PF1JidnyVF+DduVo0vVVj0u049yitDCgyNxoo8/di2n9qxRqXganhQJEyXZd
         n7y39ic5jCSqAevbeWjDEz9mvwMsDNwTQDziG4Jh5ALv5xhFIgs06VMB0+47S79qniM5
         o/aToNiM33sG4pXev1h01KzeBptWoHcrn9Nydxh2zmGoEa6mfSWrSmV6pDe4YVG8BvXg
         X8v2BKbNV6i7tOFHzot9/RGrMRjPy597ygniwivms6P7XwPJxeKiSs0TIXWJdKJUlOss
         PXlg==
X-Gm-Message-State: AC+VfDzevfVllts4mDwVicz5/AwyUNoYBecBfBvxf16StMsCWCMIbdKM
	CN/dCdPayh8Q92jXYG3jbdU3xQ1X4gv8bn5RGfmZbX2zyZh4P7gPkx9rnpOdVvwottO9jIJXo6Q
	QsTP31XFe+t0twg3H0pedJt1YV8k4
X-Received: by 2002:a17:907:36c8:b0:982:7434:ea84 with SMTP id bj8-20020a17090736c800b009827434ea84mr20116139ejc.10.1687376720990;
        Wed, 21 Jun 2023 12:45:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TlHphfBdzSgimoTMX2gKs3kWB1HVhIxvFmOgZeQqhMZ+urjdFffQFOHBX4PRccpBdoXlgKw==
X-Received: by 2002:a17:907:36c8:b0:982:7434:ea84 with SMTP id bj8-20020a17090736c800b009827434ea84mr20116127ejc.10.1687376720654;
        Wed, 21 Jun 2023 12:45:20 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:45:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230621154329-mutt-send-email-mst@kernel.org>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621152451-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FDB711FBC0528822106FDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621153237-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816D7D508F94ADA30E2CC1DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816D7D508F94ADA30E2CC1DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 07:39:19PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 3:36 PM
> > 
> > It can be helpful for debugging. E.g. if driver sets a bit that device does not
> > recognize, it can figure out that driver has it set in supported mask.
> Device is reporting error code anyway when it receives a unexpected command contents.

To driver, yes. But if you are debugging this from software device
side then getting info about driver state is helpful.

> > Or if it seems like a waste we can just ask drivers to put 0 there, works for me
> > too.
> 
> I fail to see this being any better or equal to two structures.

One structure is just simpler for software than two.

> > 
> > 
> > > Two structures are cleaner.
> > 
> > Frankly what's cleaner is what RSS is doing, supported mask in config space.
> > Was this discussed in some version? I don't remember.
> > 
> Yes, we discussed. 

Couldn't find it and I don't want us to repeat same agruments.
Which version had this field in config space?

> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

