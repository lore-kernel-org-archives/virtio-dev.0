Return-Path: virtio-dev-return-3803-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AC3A5818081
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 18:18:55 -0700 (PDT)
Message-ID: <5ACD6339.6040806@intel.com>
Date: Wed, 11 Apr 2018 09:22:01 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com> <1522031994-7246-2-git-send-email-wei.w.wang@intel.com> <20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org> <20180410211719-mutt-send-email-mst@kernel.org> <20180410135429.d1aeeb91d7f2754ffe7fb80e@linux-foundation.org> <20180411022440-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180411022440-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v29 1/4] mm: support reporting free page blocks
To: "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 04/11/2018 07:25 AM, Michael S. Tsirkin wrote:
> On Tue, Apr 10, 2018 at 01:54:29PM -0700, Andrew Morton wrote:
>> On Tue, 10 Apr 2018 21:19:31 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> Andrew, were your questions answered? If yes could I bother you for an ack on this?
>>>
>> Still not very happy that readers are told that "this function may
>> sleep" when it clearly doesn't do so.  If we wish to be able to change
>> it to sleep in the future then that should be mentioned.  And even put a
>> might_sleep() in there, to catch people who didn't read the comments...
>>
>> Otherwise it looks OK.
> Oh, might_sleep with a comment explaining it's for the future sounds
> good to me. I queued this - Wei, could you post a patch on top pls?
>

I'm just thinking if it would be necessary to add another might_sleep, 
because we've had a cond_resched there which has wrapped a __might_sleep.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

