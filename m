Return-Path: virtio-dev-return-3512-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
References: <1520304620-10753-1-git-send-email-changpeng.liu@intel.com>
 <bc8d88a4-3069-188a-99aa-c1c75a6e13b2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f52ee0f7-9eff-e5a0-70de-ece56d9d9b2d@redhat.com>
Date: Mon, 12 Mar 2018 17:28:50 +0100
MIME-Version: 1.0
In-Reply-To: <bc8d88a4-3069-188a-99aa-c1c75a6e13b2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3] virtio-blk: add discard and write
 zeroes features to specification
To: Laszlo Ersek <lersek@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, cavery@redhat.com, stefanha@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/03/2018 17:19, Laszlo Ersek wrote:
> virtio-scsi already supports discard and write zeroes, and virtio-scsi
> can be backed by SSDs. Can you please describe the use case in the
> commit message (in a few words) that needs discard / write zeroes but is
> ill-served by virtio-scsi?
> 
> I believe the spec (and implementations) should be conservative about
> feature duplication unless there's a good reason for it. I don't doubt
> you have a good reason; can you please name it in the commit message?
> I'm not questioning your motives, I'd just like to see them documented
> in the commit log.

Hi Laszlo, the basic reason is that virtio-scsi is slower than
virtio-blk. :)

Indeed DISCARD/WRITE ZEROES was a reason to use virtio-scsi instead of
virtio-blk back when it was created, but at the time DISCARD was
considered a thin provisioning feature; that is, the idea was that
guests could cooperate with the host to save host disk space and to
speed up maintenance operation such as live disk migration.

Nowadays, DISCARD has evolved into a basic disk maintenance operation
and IMO it fits within the scope of virtio-blk, as the backend of choice
for high performance I/O devices.  (Though I wouldn't be surprised
however if, in a few years, virtio-blk has become obsolete and we'll
just use NVMe.  Recent versions of the NVMe spec have taken some
inspiration from Xen and virtio ring buffers, and perform great as
virtual devices; this is a similar "convergence" to what's happening in
virtio for the new packed ring format, just in the opposite direction).

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

