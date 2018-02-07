Return-Path: virtio-dev-return-3171-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 685711CB8080
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Feb 2018 23:24:10 -0800 (PST)
Message-ID: <5A7AAA2E.5090809@intel.com>
Date: Wed, 07 Feb 2018 15:26:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517972467-14352-1-git-send-email-wei.w.wang@intel.com> <20180207062846-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207062846-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v26 2/2 RESEND] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/07/2018 12:34 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 07, 2018 at 11:01:06AM +0800, Wei Wang wrote:
>> Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature indicates the
>> support of reporting hints of guest free pages to host via virtio-balloon.
>>
>> Host requests the guest to report free page hints by sending a new cmd
>> id to the guest via the free_page_report_cmd_id configuration register.
>>
>> When the guest starts to report, the first element added to the free page
>> vq is the cmd id given by host. When the guest finishes the reporting
>> of all the free pages, VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID is added
>> to the vq to tell host that the reporting is done. Host polls the free
>> page vq after sending the starting cmd id, so the guest doesn't need to
>> kick after filling an element to the vq.
>>
>> Host may also requests the guest to stop the reporting in advance by
>> sending the stop cmd id to the guest via the configuration register.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> ---
>>   drivers/virtio/virtio_balloon.c     | 255 +++++++++++++++++++++++++++++++-----
>>   include/uapi/linux/virtio_balloon.h |   7 +
>>   mm/page_poison.c                    |   6 +
>>   3 files changed, 232 insertions(+), 36 deletions(-)
>>
>> Resend Change:
>> 	- Expose page_poisoning_enabled to kernel modules
> RESEND tag is for reposting unchanged patches.
> you want to post a v27, and you want the mm patch
> as a separate one, so you can get an ack on it from
> someone on linux-mm.
>
> In fact, I would probably add reporting the poison value as
> a separate feature/couple of patches.
>

OK. I have made them separate patches in v27. Thanks a lot for reviewing 
so many versions, I learned a lot from the comments and discussion.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

