Return-Path: <virtio-dev-return-12398-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B45C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:31:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E2393E306
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:31:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76DA498643E
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:31:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5D95A983FEA; Tue, 25 Apr 2023 06:31:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AF009863D7
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 06:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: c9ABWIpBO8yuoyU_GVpgpw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682404270; x=1684996270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8G5N+ME00TdEJpQRiOhYGKKvH6zxeIAIRDCvlVSA5Q=;
        b=MCgxGyBljJOQXpmpjEI5g5WnlS00IBwGfnbCxaLJ3XNHv5Pfkqiuw0TnxlmpNP6ywd
         LT32tu56XOawlX9N3VPBRXmDACfe03lGLGy8UUP1v96sRXwJrp8S1Yj76G38x0KAqwbH
         ZBPyYRe9QfG9TFZDHRxNyfeHHAWPyPV9ekofe+2+o47luIapIXy2rmiTVSfw3kohRaE+
         kvjhVkWE4NwhzOimE2Jy7JCPB3566QnhEgafxtfMC0Hmj44M1EKHeoGJ3FwmTHHfsDXz
         kFTuMjDHHPiDFLwi0x82oE6fM9fMSpAfENnlpz1+i5n/oVchaBBET+ChDjGoOaGMdjTk
         h33A==
X-Gm-Message-State: AAQBX9dzdzBIZ1Aatabs51kU6OGHci6vBAEpBSMQzvUgJ/1J5pHa/yeh
	gZjq8dNGvmKDGE80wW2qRfTDJgTw/0+wHNabZRbH+Xtjq54UoPPGKR0hfxU4dW9TF+vyEYBUuii
	SSFFOfRvg4XmXFV3Xd4fbrGu7EV+s
X-Received: by 2002:a17:902:e543:b0:1a1:ca4d:120a with SMTP id n3-20020a170902e54300b001a1ca4d120amr24711600plf.7.1682404270501;
        Mon, 24 Apr 2023 23:31:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z38kCYEeYn3DGkVEhSQCxFiF0sMj0/cOG9gBy8bo3vQHksMoOhZKXw6kNnTIvBS4G/3P6ifA==
X-Received: by 2002:a17:902:e543:b0:1a1:ca4d:120a with SMTP id n3-20020a170902e54300b001a1ca4d120amr24711587plf.7.1682404270156;
        Mon, 24 Apr 2023 23:31:10 -0700 (PDT)
Message-ID: <d1e62181-894c-25bb-3546-16a4f92beeb0@redhat.com>
Date: Tue, 25 Apr 2023 14:31:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>, zhenwei pi <pizhenwei@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, houp@yusur.tech
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
 <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
 <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)


在 2023/4/25 13:03, Parav Pandit 写道:
>
>
> On 4/24/2023 9:38 AM, zhenwei pi wrote:
>>
>>
>>  From the point of my view, there are 3 cases:
>> 1, Host/container scenario. For example, host kernel connects a 
>> virtio target block service, maps it as a vdx(virtio-blk) device(used 
>> by Map-Reduce service which needs a fast/large size disk). The host 
>> kernel also connects a virtio target crypto service, maps it as 
>> virtio crypto device(used by nginx to accelarate HTTPS). And so on.
>>
>>          +----------+    +----------+       +----------+
>>          |Map-Reduce|    |   nginx  |  ...  | processes|
>>          +----------+    +----------+       +----------+
>> ------------------------------------------------------------
>> Host         |               |                  |
>> Kernel   +-------+       +-------+          +-------+
>>           | ext4  |       | LKCF  |          | HWRNG |
>>           +-------+       +-------+          +-------+
>>               |               |                  |
>>           +-------+       +-------+          +-------+
>>           |  vdx  |       |vCrypto|          | vRNG  |
>>           +-------+       +-------+          +-------+
>>               |               |                  |
>>               |           +--------+             |
>>               +---------->|TCP/RDMA|<------------+
>>                           +--------+
>>                               |
>>                           +------+
>>                           |NIC/IB|
>>                           +------+
>>                               | +-------------+
>>                               +--------------------->|virtio target|
>> +-------------+
>>
>> 2, Typical virtualization environment. The workloads run in a guest, 
>> and QEMU handles virtio-pci(or MMIO), and forwards requests to target.
>>          +----------+    +----------+       +----------+
>>          |Map-Reduce|    |   nginx  |  ...  | processes|
>>          +----------+    +----------+       +----------+
>> ------------------------------------------------------------
>> Guest        |               |                  |
>> Kernel   +-------+       +-------+          +-------+
>>           | ext4  |       | LKCF  |          | HWRNG |
>>           +-------+       +-------+          +-------+
>>               |               |                  |
>>           +-------+       +-------+          +-------+
>>           |  vdx  |       |vCrypto|          | vRNG  |
>>           +-------+       +-------+          +-------+
>>               |               |                  |
>> PCI --------------------------------------------------------
>>                               |
>> QEMU                 +--------------+
>>                       |virtio backend|
>>                       +--------------+
>>                               |
>>                           +------+
>>                           |NIC/IB|
>>                           +------+
>>                               | +-------------+
>>                               +--------------------->|virtio target|
>> +-------------+
>>
> Example #3 enables to implement virtio backend over fabrics initiator 
> in the user space, which is also a good use case.
> It can be also be done in non native virtio backend.
> More below.
>
>> 3, SmartNIC/DPU/vDPA environment. It's possible to convert virtio-pci 
>> request to virtio-of request by hardware, and forward request to 
>> virtio target directly.
>>          +----------+    +----------+       +----------+
>>          |Map-Reduce|    |   nginx  |  ...  | processes|
>>          +----------+    +----------+       +----------+
>> ------------------------------------------------------------
>> Host         |               |                  |
>> Kernel   +-------+       +-------+          +-------+
>>           | ext4  |       | LKCF  |          | HWRNG |
>>           +-------+       +-------+          +-------+
>>               |               |                  |
>>           +-------+       +-------+          +-------+
>>           |  vdx  |       |vCrypto|          | vRNG  |
>>           +-------+       +-------+          +-------+
>>               |               |                  |
>> PCI --------------------------------------------------------
>>                               |
>> SmartNIC             +---------------+
>>                       |virtio HW queue|
>>                       +---------------+
>>                               |
>>                           +------+
>>                           |NIC/IB|
>>                           +------+
>>                               | +-------------+
>>                               +--------------------->|virtio target|
>> +-------------+
>>
> All 3 seems a valid use cases.
>
> Use case 1 and 2 can be achieved directly without involving any 
> mediation layer or any other translation layer (for example virtio to 
> nfs).


Not for at least use case 2? It said it has a virtio backend in Qemu. Or 
the only possible way is to have virtio of in the guest.

Thanks


> Many blk and file protocols outside of the virtio already exists which 
> achieve this. I don't see virtio being any different to support this 
> in native manner, mainly the blk, fs, crypto device.
>
> use case #3 brings additional a benefits at the same time different 
> complexity but sure #3 is also a valid and common use case in our 
> experiences.
>
> In my experience working with FC, iSCSI, FCoE, NVMe RDMA fabrics, iSER,
> A virito fabrics needs a lot of work to reach the scale, resiliency 
> and lastly the security. (step by step...)
>
> My humble suggestion is : pick one transport instead of all at once, 
> rdma being most performant probably the first candidate to see the 
> perf gain for use case #1 and #2 from remote system.
>
> I briefly see your rdma command descriptor example, which is not 
> aligned to 16B. Perf wise it will be poor than nvme rdma fabrics.
>
> For PCI transport for net, we intent to start the work to improve 
> descriptors, the transport binding for net device. From our research I 
> see that some abstract virtio descriptors are great today, but if you 
> want to get best out of the system (sw, hw, cpu), such abstraction is 
> not the best. Sharing of "id" all the way to target and bring back is 
> an example of such inefficiency in your example.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

