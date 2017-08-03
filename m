Return-Path: virtio-dev-return-2448-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D1B05818C9B
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2017 08:20:14 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Thu, 3 Aug 2017 15:20:09 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73928C971@shsmsx102.ccr.corp.intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
 <1501742299-4369-5-git-send-email-wei.w.wang@intel.com>
 <20170803091151.GF12521@dhcp22.suse.cz> <5982FE07.3040207@intel.com>
 <20170803104417.GI12521@dhcp22.suse.cz> <59830897.2060203@intel.com>
 <20170803112831.GN12521@dhcp22.suse.cz> <5983130E.2070806@intel.com>
 <20170803124106.GR12521@dhcp22.suse.cz> <59832265.1040805@intel.com>
 <20170803135047.GV12521@dhcp22.suse.cz>
In-Reply-To: <20170803135047.GV12521@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v13 4/5] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thursday, August 3, 2017 9:51 PM, Michal Hocko:=20
> As I've said earlier. Start simple optimize incrementally with some numbe=
rs to
> justify a more subtle code.
> --

OK. Let's start with the simple implementation as you suggested.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

