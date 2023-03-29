Return-Path: <virtio-dev-return-11840-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8E7C74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:18:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D87B02AC48
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:18:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CBF0E9864BC
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:18:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C194F9864A3; Wed, 29 Mar 2023 13:18:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF7539864AF
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Mar 2023 13:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Bc3j26SPMESSto5SONM-5A-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB54814459EB692BD78D1D093FDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-7-parav@nvidia.com> <87lejfnbvc.fsf@redhat.com>
 <PH0PR12MB54814459EB692BD78D1D093FDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Mar 2023 15:18:11 +0200
Message-ID: <87fs9nn1bg.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] RE: [PATCH v9 6/8] transport-ccw: Refer to the vq by its number

On Wed, Mar 29 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Wednesday, March 29, 2023 5:30 AM
>> 
>> Same comment regarding s/Previously/previously/ as for the last patch.
>>
> Will change.
>  
>> Also, I'm not that happy with the name "queue_select". Sure, it matches what
>> pci and mmio use, but ccw does not quite use the same mechanism:
>> vq_config_block is not a structure that always exists where the meaning of the
>> fields is controlled by a selector field, but a structure that is provided by the
>> caller and then filled to refer to a certain vq. I'd prefer this field to be named
>> "vq_num" or something like that.
>
> Rest of the spec uses "vqn" at places. 
> So I will change queue_select to vqn.
> Are you ok with "vqn"?

vqn works for me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

