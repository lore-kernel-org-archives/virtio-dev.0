Return-Path: <virtio-dev-return-11466-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE71C678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:22:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A085E2A8E8
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:22:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B4E69866E1
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 07:22:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 908CB9866C6; Tue,  7 Mar 2023 07:22:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E3A29866C2;
	Tue,  7 Mar 2023 07:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK9Cn3puIyFlczFfG0cz+vibdAIwDbrQVmPkDVqjgtPOiLN14HZp4CODzO9yxPkXLkKp+6GFe3DP3xkyQI6Gq+3Ns9xelhyH4l0O15LghUN7lvuEnFEQHt1XrAZmp0a/tz/k+sW7RvN97AyW1LKY7J92YhtDuIB6B57aBttgIsRDh38CV5J91E3weYUstZjHo48BvGZZIR+M+xS2d7l2h5PvKleRzQgk9Y06c7Z2JqYMpnPKB+uy28TdT4XrKlV21jKMl9mxlMPQELDY512MwLjYgcougvbM8PZ733HZzIedDQ2HqHOKdjZfOlO4aogUS3vXCejIFjbQLiPDk6MFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnKsIMidanlLGhA4FOKtkLxy4L09Z/96lxdb38j4LAU=;
 b=E16OD+ki5btzsUqaGj+bStz+EfwB2kyKMzwL7e8O3VPagg3tXE2F31HJFIgKWQ05JV9WY1rEUuxNKLBgY93a3Kb1P7RpuufmRXAhnjwyxv7eteaTpy75vczUlm26i/MnpgBQ9w7xWjXhtYPLSUkyxplqWv1ISUwK27h+tuFDlRnzHFvb7bA9kCJ4r/CE9IdZGh90G0i+9Q/McyBD8uPNezvAX3VF6PtjrVjsUHq68gaZz8FU3vaC8Kc5sMuviYtCn0bNL91pUlRekzjaYFccfDo4hyq/QbCYH2iwlj5jCPKEYSaG0Gbog768c/yMJqvAzayBfiJwyWl2Y8GOzXiHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Tue, 7 Mar 2023 08:21:54 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAbmEmwsMMxKJqeB@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho>
 <20230306175020-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306175020-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 5758ae51-0b8b-4951-0fbe-08db1edca38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q1nlpD91QPU0NgCIehZkUWRjO1IA6a5HrBE8OpGwOkdwecC61wb+Q83UU/f/QHxA6GZ1EpVc+wkHdhdjf/X8uoPoN7HYzKKnN4ok6CtklbvXRa4pLITo5FVklF0M53A0k53Oh+KZphwIhSJVQiLwrsMQzUf+B36Lt0fTyAkIDBSpYm+/o31iD1CjF6x8IrZmBlsbKkNcaMSEFLq8vKnxVIbYJ41FccRVxT2ZQM4KNsFWwkEKDafoZxqPqBeiklSzrDVfcHy+6LDKLxyWA0o9xa6scDq6olBHFXYtQUSmgsRLY1CVpVsYsb2AAZoWrQPwZxPqifdA2CJuUffIcICCPQozDiguhZ2zyJmoVw68ltxtyMkP6dwz5z3wQGPY8claj51T6VuxsiAvC63QC+QJSI/ZpwasbQS3uBMwVTzlsFS5tVzLZ5lnmxHPcs4DsvPSFv83ZtDQtq37oCJ6oLMJUdUG7tvqVPM35NDHFpI8E95SBlLwitU4G64uax9KOV4e9N4tNxaPqheRqQaBwg1hz2H9EGw2iZb+q6QCQy6e50dhWu8U3cXVGnZaJ6WyEuN5k1y8Q67Oci4eMbyPQ9CRNcXVKxuEEY9XrNP0/iNFN+sr5xyBjjnqvbecK/2+nIhy13pXWXizKiiNnh2ALbgsnItmjZy6w1V6ox8rekkZtZ9ycDBP5FG1CK8wXrqcx7vYhsTopycMjlyw1yKIHDaecV48Rz2ILMcahhX1IE2KTRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(41300700001)(33716001)(83380400001)(6506007)(6512007)(26005)(9686003)(186003)(4743002)(38100700002)(316002)(54906003)(478600001)(66556008)(66946007)(8676002)(66476007)(4326008)(6916009)(6666004)(107886003)(6486002)(966005)(86362001)(2906002)(66899018)(7416002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u04OMBJs/auyQMfzH/HM6m6hEPbb6Gt5RC6bqOfWJKtYmBCxH8l7sBJWOboa?=
 =?us-ascii?Q?e7tMnKwoXDwZOoCwI0JyZZKFkWOE8ntm1A/Q2s51IfMR5qBDDiUsa9PDoNe2?=
 =?us-ascii?Q?MhorfAOrGez6cbwq4nA7RLl2RNw7SswRgzijt10NBUcu6FQwTTxcONN7PDFY?=
 =?us-ascii?Q?Ut8lU1g10Ai2IX7WC1wRe12KMsbLUqeD3UETfFZpoT4JTKRcEqL7ws+fwuK3?=
 =?us-ascii?Q?IEx8ZYNVUsWqqpgsoM2eTpmPRczNQiIXb5kx+rlS6VMBbU6ZyduDGQCRg3Az?=
 =?us-ascii?Q?dJ47XefdcAXHmvGKgdfLWE6TtuwK1sOFYkY/mlgt9N7GDAD61qL3OGlyfJzE?=
 =?us-ascii?Q?4qPE1fwZ9u9hVCr/fiFqLYf4quxbXcWnttsmhTJ2P/ZTmMWSjyGUF6sFrfpF?=
 =?us-ascii?Q?4jkTGV8H0Ufi7Er6OM7ES/fNQbIV/soY/n1JJ3J6UPvWRDiiADdn0oai5Bc6?=
 =?us-ascii?Q?PsDAl3V0R3v5j7j3ae/xNj8e/gq2xnNiR7XEbBLN9zjieBi3YNpks5st9IsP?=
 =?us-ascii?Q?4okkiHBfiZ7yMJKlji17tfooa34hCj5eZq4BwuAPqEt3g/WKLjkaA7klID5u?=
 =?us-ascii?Q?wASDVGBlq/Jm0BOd/hdMlBy8LI0T6/8dze57xoQwf8Pn9A9WaIRMbvbfLojS?=
 =?us-ascii?Q?jRx2gMWY79tK8VEcZ/Twh9nt3KajaTVBGo2t1mUnldip+zdote7sBe8bS8pD?=
 =?us-ascii?Q?9m+ziJnAvUMuBepiwf95d6aBH+yPP0AZ0eHJU4dsNCeW1cpIidpnI1YHeLVK?=
 =?us-ascii?Q?ubK0AVJhv1vQh4kahqq1a21LL238EXGdH+MXP4h7SEcNwYJ7t5BR8bwFNOja?=
 =?us-ascii?Q?RV1i4GN8lfDbN5bUKhKRYdbx0H7pzGZIE5TZ3iCfd16zkX9ncl2FKl36kKcY?=
 =?us-ascii?Q?EjeIuVF/zGSCuI0h36QUIdRoJIh9WHXEdD4ARQx6c29H8ecn69aJgwkfR6l6?=
 =?us-ascii?Q?A7ImliUBRNi1K+xTIuo9BPIazSoZDGTWWDwSK6ATl8AWJThHJhl12JiBGGyf?=
 =?us-ascii?Q?81mMe41o709lIkFuvqtmRliqNaJixS8ri4kP/BvWzkVt23xAV+y10M8qnMeE?=
 =?us-ascii?Q?NZQ8pVx+Vz3WnVQuW/5YkVJmUHgwXoQEylIyBivHANNI7lWOPUNZGuq6exEM?=
 =?us-ascii?Q?mziXfjfHWaCEis3fTHi72AI8hCosesdd7nZypqPWc0v3BypkPP7pvKVhRePa?=
 =?us-ascii?Q?c80hVEW+9lwETBCaqGd8MP/rL8YGpJr+NI/gP3A9HL1C8i8WDWfdkTCsOvrZ?=
 =?us-ascii?Q?gTqF3gibPagTZO0t4V+HY9kZImzT1csx18nQCiUjxIJxRCnhexkWtksfRTXC?=
 =?us-ascii?Q?g3iqU6Y22l2R32RjPCT2yurNLBEV79Esxo36MD+8q8qnouseqeWC2c4foTTY?=
 =?us-ascii?Q?aks334fihTGw1YOlw3/hskfvLi7TptnVRL/p0cZIPsgu7Je7PJSWKCAFirzz?=
 =?us-ascii?Q?tHWcdUrQKGFO+Qa+eOcNkgYjCgS1l+Cn2PFCOH3S0d3PJlKeFsBB0v0xZ16a?=
 =?us-ascii?Q?haqAHmHlmBT6TRljhQMkVy5LL5iLZJ1Gc3Au8TuLPvcOhYFC1egJeuMkKWHC?=
 =?us-ascii?Q?yaikFbLU2aW9qHPpAPlq+L/sMv5Let17y8mrz9cj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5758ae51-0b8b-4951-0fbe-08db1edca38a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:21:59.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NTUUvzJroD98qJZocZllvSWofZs2kqJ6S38/545kT8t8NRoAn/wPLp+o+Ma81Tf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management 

Mon, Mar 06, 2023 at 11:54:45PM CET, mst@redhat.com wrote:
>On Mon, Mar 06, 2023 at 01:29:30PM +0100, Jiri Pirko wrote:
>> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
>> 
>> [...]
>> 
>> >
>> >TODO (maybe?) - probably ok to defer until this part is upstream:
>> >
>> >	Add "all members" member id.
>> >
>> >	Add commands for MSI, feature discovery.
>> >
>> >	Add commands for transport vq.
>> >
>> >
>> >My intent is to try and support both SR-IOV and SIOV
>> >usecases with the same structure and maybe even the same
>> >VQ.
>> 
>> Sorry to be late to the party, I'm trying to catch up. Is it common to
>> have cover letter for features this brief? I mean, from the cover
>> letter, I'm totally unable to understand what you are introducing here.
>> 
>> Could you elaborate about what you are aiming to achive with this?
>> Could you shed some usecases perhaps?
>> 
>> I have to be missing something obvious, but I don't get why any notion
>> of SR-IOV could be beneficial for virtio.
>> 
>
>Good point, I'll add a bit of motivation.
>
>For SR-IOV, it is not unusual for PFs to excercise control over VFs.

I understand the concepts of SR-IOV. Yet I fail to see the need of such
concept in virtio world. SR-IOV is very specific solution for PCI
functions instantiation, and I believe that it is already considered
quite limiting in many aspects. Does not make sense to me to introduce
it for virtio. But again, I may be missing something crucial, I just
would like to see the motivation, needs, usecases for this crystal
clear, which is opposite to the current cover letter I'm afraid :/


>There is interest in the community to include an interface to allow this
>in the virtio spec, when the PF is a virtio device.  This is what this
>patch does.

Yeah, but why? As I asked before, what are the usecases? The fact there
is interest in the community does not mean it makes sense to have it :)


>
>
>
>
>> >
>> >For example, it might make sense to split creating/destroying
>> >SIOV devices from the transport passing data from the guest - the
>> >driver would then not negotiate VIRTIO_F_SR_IOV (which
>> >then means auto-provisioning).
>> >
>> >This is out of RFC, since we have two commands which are useful
>> >to discover supported group types (ATM can be none or SR-IOV).
>> >
>> >
>> >Michael S. Tsirkin (10):
>> >  virtio: document forward compatibility guarantees
>> >  admin: introduce device group and related concepts
>> >  admin: introduce group administration commands
>> >  admin: introduce virtio admin virtqueues
>> >  pci: add admin vq registers to virtio over pci
>> >  mmio: document ADMIN_VQ as reserved
>> >  ccw: document ADMIN_VQ as reserved
>> >  admin: command list discovery
>> >  admin: conformance clauses
>> >  ccw: document more reserved features
>> >
>> > admin.tex        | 540 +++++++++++++++++++++++++++++++++++++++++++++++
>> > content.tex      | 112 +++++++++-
>> > introduction.tex |   3 +
>> > 3 files changed, 653 insertions(+), 2 deletions(-)
>> > create mode 100644 admin.tex
>> >
>> >-- 
>> >MST
>> >
>> >
>> >This publicly archived list offers a means to provide input to the
>> >OASIS Virtual I/O Device (VIRTIO) TC.
>> >
>> >In order to verify user consent to the Feedback License terms and
>> >to minimize spam in the list archive, subscription is required
>> >before posting.
>> >
>> >Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> >Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> >List help: virtio-comment-help@lists.oasis-open.org
>> >List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> >Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> >List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> >Committee: https://www.oasis-open.org/committees/virtio/
>> >Join OASIS: https://www.oasis-open.org/join/
>> >
>> 
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>> 
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>> 
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

