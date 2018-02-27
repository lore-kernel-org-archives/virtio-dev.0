Return-Path: virtio-return-2918-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1519633014-8683-1-git-send-email-changpeng.liu@intel.com>
 <e264f4f4-ee96-e77a-54c9-a4f07b996359@redhat.com>
 <FF7FC980937D6342B9D289F5F3C7C2625B613009@SHSMSX103.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b74b21f-5851-1e89-c77b-89fff8f16106@redhat.com>
Date: Tue, 27 Feb 2018 09:42:06 +0100
MIME-Version: 1.0
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B613009@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [RFC] virtio-blk: add discard and write zeroes
 features to specification
To: "Liu, Changpeng" <changpeng.liu@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
Cc: "cavery@redhat.com" <cavery@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>, "Harris, James R" <james.r.harris@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27/02/2018 06:45, Liu, Changpeng wrote:
>> Perhaps we can put a bit here saying whether write_zeroes will ever look
>> at the \field{unmap} bit?  Like:
>>
>> 	u8   write_zeroes_may_unmap;
>
> I do take this into consideration, if write zeroes is supported and discard is not supported,
> even the OS send write zeroes command with unmap bit enabled, the backend will also
> ignore this bit, so the configuration parameter seems useless.

The reason is that it lets the guest OS know if WRITE ZEROES with UNMAP
will be fast or not.  It's not super important, but it is easy enough to
add and also easy enough to fill in for the host.

Paolo

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

