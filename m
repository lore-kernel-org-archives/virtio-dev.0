Return-Path: <virtio-dev-return-12576-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFB9C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:12:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E80CB2AC4E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:12:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCA2A9866B9
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:12:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B35AA9866B5; Fri,  5 May 2023 15:12:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F69A9866B6
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jmgaXznvP1SZyMUMIoEgxQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299526; x=1685891526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeSXx6p5X5ymJEHZ/AFzysqPjtcwwZdOCBQFvTMHkUw=;
        b=h1iz6TEJNrG2VVkd+LjVPxqVWk/iKFgJDDlWzrC0L/jCZBREHJs+nSvbLKESMlBIDP
         ++Lwboi00MLuWdfX1EsZPU3bJFhD4r19t9hvj+zz71H+fHfzAfsiWk3VfvTsS8vxx6z1
         duvxlfyfmluoYJql0o0nOcCmWJ8t9Up3KuBCISdpm9M3uOvKPLoxTD3871Vl43AHjyGg
         9YO3/wsuGq3YTcYlW31txrVUYh/jCpEFc6bAZL1V3kcZ5tQGj5cfG1g4M81zrtolWBT0
         yQliGtPsAX477nL6PEbHcwJ534ogmGgJhpISxycZi/kWCKISo5QSlJKbZnTr5qp+FGVz
         t5Fw==
X-Gm-Message-State: AC+VfDxJPTYGnhS6BgbN9uuf0D2srRDImoYqwlpswKqxTuuCwMetLpTg
	r+6T66gsnvX5/PYgy7+mQMeoJnsEVSvIotcvqlb686AIAGZp2mGZKy2cWPFImxarhajcJucqblW
	1dmyyKvHCRDjPpiS5v6OrUXBS0Zy1
X-Received: by 2002:a17:907:360c:b0:94a:845c:3528 with SMTP id bk12-20020a170907360c00b0094a845c3528mr1438272ejc.45.1683299526427;
        Fri, 05 May 2023 08:12:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56pjHBjjifJsmlu/AkVw1FD94ZlisKa7HToYhQZARTWO64cYn6CbsMBAifqDZTLCXRqXgL8Q==
X-Received: by 2002:a17:907:360c:b0:94a:845c:3528 with SMTP id bk12-20020a170907360c00b0094a845c3528mr1438241ejc.45.1683299526067;
        Fri, 05 May 2023 08:12:06 -0700 (PDT)
Date: Fri, 5 May 2023 11:12:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230505111144-mutt-send-email-mst@kernel.org>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
 <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
 <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
 <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b7addd39-d913-700f-ac67-1412825d580b@nvidia.com>
 <PH0PR12MB54819792ED9279E66B63AC26DC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819792ED9279E66B63AC26DC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci

On Thu, Apr 27, 2023 at 12:11:31AM +0000, Parav Pandit wrote:
> 
> > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Sent: Wednesday, April 26, 2023 6:31 PM
> > >>>
> > >>>>> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> > >>>>> +configures any administration virtqueues, the driver MUST
> > >>>>> +configure the administration virtqueues using the index in the
> > >>>>> +range \field{admin_queue_index} to \field{admin_queue_index} +
> > >>>>> +\field{admin_queue_num} - 1 inclusive.
> > >>>>> +The driver MAY configure less administration virtqueues than
> > >>>>> +supported by the device.
> > >>>>
> > >>>> we need to say something about other virtq's indexes.
> > >>>> For example, if aq index = 0 then for the vblk device the request
> > >>>> queues would start from index = 1.
> > >>>>
> > >>>> can we address this ?
> > >>>
> > >>> It may slightly complicate the device implementation when device
> > >>> dynamically changes the VQ indices based on the negotiation of the
> > >>> feature bit.
> > >>> Also the drivers with and without need a different VQ index handling.
> > >>>
> > >>> I am thinking that aq index should not overlap with the vq index in
> > >>> range exposed by num_queues field.
> > >>>
> > >>> This also aligns to the exclusion of aq count from num_queues field.
> > >>
> > >> The namespace of the aq and other vq index is the same.
> > >> And the configuration is done using the same queue_select and other
> > registers.
> > >> Thus, we need to address the above comment otherwise all the device
> > >> virtqueues chapters are wrong.
> > >
> > > Michael has added below line in this patch in num_queues description so it
> > covers the exclusion part.
> > >
> > > +        This excludes administration virtqueues if any are supported.
> > >
> > 
> > This is not related to what I was talking about.
> > 
> > For example if vnet device:
> > 
> > 0 receiveq1
> > 1 transmitq1
> > ...
> > 2(N-1) receiveqN
> > 2(N-1)+1 transmitqN
> > 2N controlq
> > N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated,
> > otherwise N is set by max_- virtqueue_pairs.
> > controlq only exists if VIRTIO_NET_F_CTRL_VQ set
> > 
> > and in vfs device:
> > 
> > 0 hiprio
> > 1...n request queues
> > 
> > So if one device will expose adminq that will be with index 0 the above is wrong
> > description.
> > 
> > Agree that this should be addressed ?
> 
> Oh yes, I agree.
> In response [1] I acked it as,
> 
> "I am thinking that aq index should not overlap with the vq index in range exposed by num_queues field."
> 
> So, admin_queue_index description needs to have description like below.
> 
> admin_queue_index must be greater than or equal to the value of num_queues.
> 
> Yes?
> 
> [1] https://lore.kernel.org/virtio-dev/a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com/


this is present in the conformance clause patch:

+If VIRTIO_F_ADMIN_VQ has been negotiated, the value
+\field{admin_queue_index} MUST be equal to, or bigger than
+\field{num_queues}; also, \field{admin_queue_num} MUST be
+smaller than, or equal to 0x10000 - \field{admin_queue_index},
+to ensure that indices of valid admin queues fit into
+a 16 bit range beyond all other virtqueues.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

