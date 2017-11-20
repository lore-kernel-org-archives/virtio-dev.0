Return-Path: virtio-dev-return-2703-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D3F458190D5
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Nov 2017 03:40:55 -0800 (PST)
Message-ID: <5A12BFB0.5030402@intel.com>
Date: Mon, 20 Nov 2017 19:42:40 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com> <1509696786-1597-7-git-send-email-wei.w.wang@intel.com> <5A097548.8000608@intel.com> <20171113192309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171113192309-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v17 6/6] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/14/2017 01:32 AM, Michael S. Tsirkin wrote:
> You should Cc Nitesh who is working on a related feature.

OK, I'll do. We have two more issues which haven't been discussed yet, 
please have a check below.

>
> On Mon, Nov 13, 2017 at 06:34:48PM +0800, Wei Wang wrote:
>> Ping for comments, thanks.
>>
>> On 11/03/2017 04:13 PM, Wei Wang wrote:
>>> +static void virtballoon_cmd_report_free_page_start(struct virtio_balloon *vb)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	vb->report_free_page_stop = false;
> this flag is used a lot outside any locks. Why is this safe?
> Please add some comments explaining access to this flag.

I will revert the logic as suggested: vb->report_free_page. Also plan to 
simplify its usage as below.

The flag is set or cleared in the config handler according to the 
new_cmd_id given
by the host:

new_cmd_id=0:                    WRITE_ONCE(vb->report_free_page, 
false); // stop reporting
new_cmd_id != old_cmd_id: WRITE_ONCE(vb->report_free_page, true);  // 
start reporting


The flag is read by virtio_balloon_send_free_pages() - the callback to 
report free pages:

if (!READ_ONCE(vb->report_free_page))
                 return false;

I don't find where it could be unsafe then (the flag is written by the 
config handler only).



>
>>> +}
>>> +
>>>    static inline s64 towards_target(struct virtio_balloon *vb)
>>>    {
>>>    	s64 target;
>>> @@ -597,42 +673,147 @@ static void update_balloon_size_func(struct work_struct *work)
>>>    		queue_work(system_freezable_wq, work);
>>>    }
>>> -static int init_vqs(struct virtio_balloon *vb)
>>> +static bool virtio_balloon_send_free_pages(void *opaque, unsigned long pfn,
>>> +					   unsigned long nr_pages)
>>>    {
>>> -	struct virtqueue *vqs[3];
>>> -	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
>>> -	static const char * const names[] = { "inflate", "deflate", "stats" };
>>> -	int err, nvqs;
>>> +	struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
>>> +	void *addr = (void *)pfn_to_kaddr(pfn);
> How do we know all free pages have a kaddr?

For x86_64, it works well since the kernel has all the physical memory 
mapped already. But for 32-bit kernel, yes, the high memory usually 
isn't mapped and thus no kaddr. Essentially, this pfn_to_kaddr convert 
isn't necessary, we do it here because the current API that virtio has 
is based on "struct scatterlist", which takes a kaddr, and this kaddr is 
then convert back to physical address in virtqueue_add() when assigning 
to desc->addr.

I think a better solution would be to add a new API, which directly 
assigns the caller's guest physical address to desc->addr, similar to 
the previous implementation "add_one_chunk()" 
(https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02452.html). 
But we can change that to a general virtio API:
virtqueue_add_one_desc(struct virtqueue *_vq, u64 base_addr, u32 size, 
bool in_desc, void *data);

What do you think?

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

