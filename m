Return-Path: virtio-dev-return-3076-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B26195819139
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 19:28:59 -0800 (PST)
Message-ID: <5A6AA107.3000607@intel.com>
Date: Fri, 26 Jan 2018 11:31:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com> <1516871646-22741-3-git-send-email-wei.w.wang@intel.com> <20180125154708-mutt-send-email-mst@kernel.org> <5A6A871C.6040408@intel.com> <20180126042649-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180126042649-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v25 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/26/2018 10:42 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 26, 2018 at 09:40:44AM +0800, Wei Wang wrote:
>> On 01/25/2018 09:49 PM, Michael S. Tsirkin wrote:
>>> On Thu, Jan 25, 2018 at 05:14:06PM +0800, Wei Wang wrote:
>>>

>> The controversy is that the free list is not static
>> once the lock is dropped, so everything is dynamically changing, including
>> the state that was recorded. The method we are using is more prudent, IMHO.
>> How about taking the fundamental solution, and seek to improve incrementally
>> in the future?
>>
>>
>> Best,
>> Wei
> I'd like to see kicks happen outside the spinlock. kick with a spinlock
> taken looks like a scalability issue that won't be easy to
> reproduce but hurt workloads at random unexpected times.
>

Is that "kick inside the spinlock" the only concern you have? I think we 
can remove the kick actually. If we check how the host side works, it is 
worthwhile to let the host poll the virtqueue after it receives the cmd 
id from the guest (kick for cmd id isn't within the lock).


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

