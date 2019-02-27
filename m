Return-Path: virtio-comment-return-667-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 27 Feb 2019 14:50:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190227145050.0038e037.cohuck@redhat.com>
In-Reply-To: <20190222115433.7160-4-dgilbert@redhat.com>
References: <20190222115433.7160-1-dgilbert@redhat.com>
	<20190222115433.7160-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [PATCH v2 3/3] shared memory: Define mmio registers
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 22 Feb 2019 11:54:33 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Define an MMIO interface to enumerate and map shared
> memory regions.
> 
> Note: This hasn't been implemented.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  content.tex | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

(...)

> @@ -1815,6 +1840,13 @@ If both values are valid, it MUST read \field{DeviceID}
>  and if its value is zero (0x0) MUST abort initialization and
>  MUST NOT access any other register.
>  
> +Devices expecting shared memory regions MUST enumerate the
> +regions by selecting each region in tern and checking that the

s/tern/turn/

> +length is not -1.
> +
> +Devices not expecting shared memory MUST NOT use the shared
> +memory registers.

Isn't that the _driver_ requirements section? These sentences also make
more sense if they talk about a driver expecting something.

What I also find a bit confusing is the requirement that they enumerate
all regions (at least, that's how I read it.)

Say we have a device type with shared regions foo, bar, and the
optional baz. It should be fine if a driver finds foo, bar, and baz; as
well as if a driver only finds foo and bar. Conversely, a driver only
looking for foo and bar should work with a device exposing foo, bar,
and baz.

> +
>  Further initialization MUST follow the procedure described in
>  \ref{sec:General Initialization And Device Operation / Device Initialization}~\nameref{sec:General Initialization And Device Operation / Device Initialization}.
>  


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

