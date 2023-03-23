Return-Path: <virtio-dev-return-11745-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93956C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 02:27:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B415A3309A
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 02:27:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABF60986475
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 02:27:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A1EF29860C5; Thu, 23 Mar 2023 02:27:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F890986455;
	Thu, 23 Mar 2023 02:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VeSPHkj_1679538421;
Message-ID: <2877764d-56e2-98c9-9e15-811d99d75e0a@linux.alibaba.com>
Date: Thu, 23 Mar 2023 10:26:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com> <20230322124508-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B3FD31F529EDF420FACEDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230322125058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B513EF0CAD4020A4C246DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481B513EF0CAD4020A4C246DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net:
 support the virtqueue coalescing moderation



在 2023/3/23 上午1:02, Parav Pandit 写道:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, March 22, 2023 12:53 PM
>>
>> On Wed, Mar 22, 2023 at 04:49:58PM +0000, Parav Pandit wrote:
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Wednesday, March 22, 2023 12:47 PM
>>>>
>>>> I agree with Cornelia here. Yes if devices do not want to trust
>>>> drivers then they will validate input but what exactly happens then is
>> currently up to device.
>>>> If we want to try and specify devices in all cases of out of spec
>>>> input that's a big project, certainly doable but I would rather not
>>>> connect it to this, rather boutique, feature.
>>> Both of your and Cornelia's comment is abstract to me.
>>> We cannot change past.
>> But we can make sure things are consistent. Currently we don't describe device
>> behaviour if driver is out of spec and I see 0 reasons to start doing it with
>> coalescing commands specifically.
>>
>>> For the new command of interest here, hen driver supplied incorrect values,
>> the device will return error.
>>
>> It might be easier for device to just set NEEDS_RESET and stop responding.
> This approach of treating all errors as a fatal category is completely the opposite of making the device and driver resilient to (recoverable) errors.
> We shouldn't go this route.
> Different discussion...
>
>> For
>> a hypervisor implementation that's often better than returning error since
>> device state is then preserved making things easier to debug.
>>
>>> How to implement is upto the device to figure out.
>>
>> what to do is also up to the device.
> Previously error code as not returned hence new command cannot return the error code is going backward.
>
> Returning the failure code is a way to indicate that the driver had a recoverable error.

I agree with you. Part of the specification [1] covered something we're 
talking about, e.g. if an untrusted driver sends a disabled vq, the 
device returns an error:

[1] +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and 
VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the 
designated virtqueue is disabled.

Maybe we should modify [1] to:

"The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and 
VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the 
designated \field{vqn} is not the virtqueue number of an enabled 
transmit or receive virtqueue."


Thanks!


>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

