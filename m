Return-Path: <virtio-dev-return-14176-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ADDC46CCD
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 09:31:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 94BCA120D4D
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 09:31:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 888089865B0
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 09:31:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6E4E798654A; Wed, 20 Dec 2023 09:31:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A3C3986547;
	Wed, 20 Dec 2023 09:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VytmXYz_1703064693;
Message-ID: <587686d2-79c7-41a3-aad0-cadec070694c@linux.alibaba.com>
Date: Wed, 20 Dec 2023 17:31:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20231212032713-mutt-send-email-mst@kernel.org>
 <bfd25f86-4292-45d2-a7a2-fe61bde0edb4@linux.alibaba.com>
 <b739d275-3664-4509-8a91-f19690719475@linux.alibaba.com>
 <fafa078b-14f5-460d-b03e-122afb9156ba@linux.alibaba.com>
 <CACGkMEuCb13=-b1yMYi3NOehL+6eNWjWsmBHfcYho1w0HwpVBA@mail.gmail.com>
 <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com>
 <CACGkMEsh9h_syGag48DL9rSSH2Yp4Ht-ES4gA-5rv16Lih_tJw@mail.gmail.com>
 <df90d58d-7e4e-44d7-8896-5fc5b131c164@linux.alibaba.com>
 <CACGkMEsxsLP=hnybYi2fiKXFq1U1zo+EuKnzfnbT3K_Wcrug5Q@mail.gmail.com>
 <68b0d00b-8b3b-4bd4-9e7c-c3b811dafd8c@linux.alibaba.com>
 <20231220020428-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20231220020428-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v5] virtio-net: device does not deliver partially checksummed packet and may
 validate the checksum



在 2023/12/20 下午3:35, Michael S. Tsirkin 写道:
> On Wed, Dec 20, 2023 at 02:30:01PM +0800, Heng Qi wrote:
>> But why are we discussing this?
> I think basically at this point everyone is confused about what
> the feature does. right now we have packets
> with
> #define VIRTIO_NET_HDR_F_NEEDS_CSUM     1       -> partial
> #define VIRTIO_NET_HDR_F_DATA_VALID     2       -> unnecessary
> and packets without either 			-> none
>
> if both 1 and 2 are set then linux uses VIRTIO_NET_HDR_F_NEEDS_CSUM but
> I am not sure it's not a mistake. Maybe it does not matter.
>
> What does this new thing do? So far all we have is "XDP will turn it on"
> which is not really sufficient. I assumed it somehow replaces
> partial with complete. That would make sense for many reasons,
> for example the checksum fields in the header can be reused
> for other purposes. But maybe not?


Hello Jaosn and Michael. I've summarized our discussion so far, so check 
it out below. Thank you very much!

 From the nic perspective, I think Jason's statement is correct, the 
nic's checksum capability and setting DATA_VALID in flags
should not be determined by GUEST_CSUM feature. As long as the rx 
checksum offload is turned on, DATA_VALID
should be set. (Though we now bind GUEST_CSUM negotiation with rx 
checksum offload.)

Therefore, we need to pay attention to the information of rx checksum 
offload. Please check it out:

Devices that comply with the below description are said to be existing 
devices:
     "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST* 
set flags to zero and SHOULD supply a fully checksummed packet to the 
driver."

As suggested by Jason, devices that comply with the below description 
are said to be new devices:
     "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MAY* set 
flags to zero and SHOULD supply a fully checksummed packet to the driver."


1. Rx checksum offload is turned on
GUEST_CSUM feature is not negotiated. (now it is only used to indicate 
whether the driver can handle partially checksummed packets)
    a. Existing devices continue to set flags to 0;
    b. New devices may validate the packets and have flags set to 
DATA_VALID;
    c. Migration.
        Migration of existing devices continues to check GUEST_CSUM 
feature and rx checksum offload;
        Migration of new devices only check rx checksum offload;
        Without updating the existing migration management and control 
system, existing devices cannot be migrated to new devices, and new 
devices cannot be migrated to existing devices.
    d. How offload should be controlled now needs attention. Should 
CTRL_GUEST_OFFLOADS still issue GUEST_CSUM feature bit to control the rx 
checksum offload?

2. The new FULLY_CSUM feature must disable NEEDS_CSUM.
The device may set DATA_VALID regardless of whether FULLY_CSUM or 
GUEST_CSUM is negotiated.
    a. Rx fully checksum offload is still controlled by 
CTRL_GUEST_OFFLOADS carrying GUEST_FULLY_CSUM.
    b. When the rx device receives a partially checksummed packet, it 
should calculate the checksum and delivering a fully checksummed packet 
to the driver.


So now, if we modify the existing spec as Jason suggested, I think it's OK.
But we need to find out how to control rx checksum offload. WDYT?

Thanks!

>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

