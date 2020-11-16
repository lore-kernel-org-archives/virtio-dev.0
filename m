Return-Path: virtio-comment-return-1517-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
 <83052aa7-8815-ce9d-3c9f-59d863107702@redhat.com>
 <20201110053225-mutt-send-email-mst@kernel.org>
 <5a0fcb8b-80a1-d1e0-5d9f-2f6cc003adc2@redhat.com>
 <616323bf-25a5-d951-cd4c-3d67f08f5af8@intel.com>
 <20201112035331-mutt-send-email-mst@kernel.org>
 <c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com>
 <ba89c7cc-fad4-e0ca-642a-220364ffd05a@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e79f44b9-8620-3635-1f60-90a4c6dd4e2e@redhat.com>
Date: Mon, 16 Nov 2020 09:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <ba89c7cc-fad4-e0ca-642a-220364ffd05a@intel.com>
Subject: Re: [virtio-comment] [PATCH v4] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jie Deng <jie.deng@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, yu1.wang@intel.com, conghui.chen@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 16/11/20 03:12, Jie Deng wrote:
> Fore example, the frontend may kick the sequence "write read read ..." 
> to the backend at a time.
> 
> The segments can be aggregated into "i2c_msg list" and sent to the 
> hardware at a time by the backend.
> 
> The host native drivers will finally send these segments using the 
> methods they support.

If so, the spec needs to specify what the backend must/should/may 
aggregate into a single host-side transaction.

What my proposal does is essentially saying that the backend MUST 
aggregate a write and a read segment into a single transaction if it is 
sent with a single virtio-i2c request.

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

