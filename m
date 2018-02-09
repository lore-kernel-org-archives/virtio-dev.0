Return-Path: virtio-dev-return-3192-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 24ACC58191BA
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Feb 2018 19:09:10 -0800 (PST)
Message-ID: <5A7D116B.9070502@intel.com>
Date: Fri, 09 Feb 2018 11:11:39 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com> <20180208215048-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180208215048-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v28 0/4] Virtio-balloon: support free page reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/09/2018 03:55 AM, Michael S. Tsirkin wrote:
> On Thu, Feb 08, 2018 at 05:50:16PM +0800, Wei Wang wrote:
>
>> Details:
>> Set up a Ping-Pong local live migration, where the guest ceaselessy
>> migrates between the source and destination. Linux compilation,
>> i.e. make bzImage -j4, is performed during the Ping-Pong migration. The
>> legacy case takes 5min14s to finish the compilation. With this
>> optimization patched, it takes 5min12s.
> How is migration time affected in this case?


When the linux compilation workload runs, the migration time (both the 
legacy and this optimization case) varies as the compilation goes on. It 
seems not easy to give a static speedup number, some times the migration 
time is reduced to 33%, sometimes to 50%, it varies, and depends on how 
much free memory the system has at that moment. For example, at the 
later stage of the compilation, I can observe 5GB memory being used as 
page cache. But overall, I can observe obvious improvement of the 
migration time.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

