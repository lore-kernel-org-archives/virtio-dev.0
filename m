Return-Path: <virtio-dev-return-10103-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5303598642B
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 14:22:26 +0000 (UTC)
Message-ID: <a0773598-1ce5-1b98-5aa1-95350bccdbb6@bytedance.com>
Date: Mon, 31 Oct 2022 14:22:22 +0000
MIME-Version: 1.0
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-4-usama.arif@bytedance.com> <Y1r3wEnQwTsZqGWg@fedora>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <Y1r3wEnQwTsZqGWg@fedora>
Subject: [virtio-dev] Re: [External] Re: [PATCH v3 3/4] content: Introduce driver/device
 auxiliary notifications for MMIO
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 27/10/2022 22:27, Stefan Hajnoczi wrote:
> On Fri, Oct 07, 2022 at 05:56:42PM +0100, Usama Arif wrote:
>> This includes the additions to the corresponding device and driver
>> conformances.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> You can keep this. One thought:
> 
> I realized that virtio-mmio support won't be very useful until
> virtio-mmio gets MSI-X support because drivers currently cannot
> differentiate between device auxiliary notifications.
> 
> Stefan

Did you mean drivers currently cannot differentiate between "driver" 
auxiliary notifications? The driver will be able to be able to choose 
the index it wants to notifiy using DeviceAuxNotificationIndex.

I can add the following line in the Interrupt Status change of the patch 
if it makes sense?
"As MSI-X is not available, it is not possible to determine which driver 
auxiliary notification occured, hence only a single notification is 
supported."

Thanks,
Usama

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

