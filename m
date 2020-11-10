Return-Path: virtio-comment-return-1503-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <83052aa7-8815-ce9d-3c9f-59d863107702@redhat.com>
Date: Tue, 10 Nov 2020 09:05:47 +0100
MIME-Version: 1.0
In-Reply-To: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
Subject: Re: [virtio-comment] [PATCH v4] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/11/20 08:31, Jie Deng wrote:
> virtio-i2c is a virtual I2C adapter device. It provides a way to=20
> =EF=AC=82exibly communicate with the I2C slave devices from the guest. Th=
is=20
> patch adds the specification for this device.

Sorry I didn't reply last week, but I really would prefer if virtio-i2c=20
supported write-read transactions.

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

