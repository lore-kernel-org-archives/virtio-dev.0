Return-Path: <virtio-dev-return-11711-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D550BC76195
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:44:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4906D3E333
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:44:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4173A98646A
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:44:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 36F96986458; Wed, 22 Mar 2023 16:44:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27A76986451
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 16:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ApCGrDBwNc-8HibCCzB1iQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, David
 Edmondson <david.edmondson@oracle.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 22 Mar 2023 17:44:27 +0100
Message-ID: <87jzz8hh1w.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation

On Wed, Mar 22 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Wednesday, March 22, 2023 12:37 PM
>> 
>> On Wed, Mar 22 2023, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> >> From: Cornelia Huck <cohuck@redhat.com>
>> >> Sent: Wednesday, March 22, 2023 11:21 AM
>> >>
>> >> On Wed, Mar 22 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>> >>
>> >> > +The driver MUST NOT set \field{vqn} to any value other than an
>> >> > +enabled
>> >> transmit or receive virtqueue number.
>> >>
>> > Why do you suggest a negative statement here?
>> > How is it better than,
>> > The driver MUST set ...
>> 
>> So make it
>> 
>> "The driver MUST set \field{vqn} to the virtqueue number of an enabled
>> transmit or receive virtqueue." ?
>> 
> Looks good.
>
>> > The device will anyway have to check and apply the parameter to the right
>> virtqueue.
>> > And if the vq is not enabled or vq is not tx or rx vq, it needs to fail the
>> command.
>> 
>> Well, I think we want to avoid having to add a normative statement for the
>> device, so we need to be strict with what the driver is allowed to do.
> Drivers are untrusted entities.
> device normative statement is needed, it will do the checks anyway where it is applying the config.

But isn't that implementation specific? I.e. if the driver sends junk,
the device needs to be able to deal with it in any case.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

