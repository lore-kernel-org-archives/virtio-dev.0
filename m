Return-Path: virtio-comment-return-820-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ecbc7e5-4539-d1f7-eabd-240f5ddd38c5@redhat.com>
Date: Mon, 29 Jul 2019 11:19:25 +0200
MIME-Version: 1.0
In-Reply-To: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-comment] [PATCH] Add virtio rpmb device specification
To: Huang Yang <yang.huang@intel.com>, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, mst@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 29/07/19 09:48, Huang Yang wrote:
>  
> But virtualization software like Qemu doesn't provide eMMC/UFS/NVMe
> RPMB emulation. It blocks the OS like Trusty or OP-TEE running in a
> virtualization environment. For instance, Google right now uses another
> way to work around RPMB emulation issue when running Trusty in ARM Qemu:
> https://android.googlesource.com/trusty/external/trusty/+/refs/heads/master/test-runner/
> 
> Virtio RPMB standardization will definitely benefit OP-TEE,
> Google Trusty TEE, Qemu, OVMF or other modules to develop the RPMB
> based secure storage in virtualization.
>  

Is there any reason to use a new virtio-blk device, and not add this
functionality to virtio-blk?

Paolo

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

