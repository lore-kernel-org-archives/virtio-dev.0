Return-Path: <virtio-dev-return-13462-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28393C001DE
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 04:22:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 81A29444E
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 04:22:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A5AE9866E3
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 04:22:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6EAA99866DF; Fri,  4 Aug 2023 04:22:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B18B9866DE;
	Fri,  4 Aug 2023 04:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhgLM2woIm0iLuEWPT8XGv7JCec52pADy3fg8pvm+e1e+UEhrbp7ul9BCVK5m8QSToT8FIQSCj1nwTim7de8keSMFVGSE05auhlMW51FN3ndPHxH81OpG09b/iO41pjVa6CUwNgRGW63vmPzL8CO4NgJOPalKOFq2ZaqO8V982e7J5hxUeiHDZ85qPQUdPacUJlsZy6pT8D5rgGq8jHr4brqZv73MXx70uAwTxnxG7UK/VBtSIclo13Z9UDWIVZHgrTUDrB++cqMDdsazgR1apwkudG2y42+Ke8R2BVgRZAMhAg4+RHbc+tG5Dbch6I1LlxMTi+bOC1XDpg8fTNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfsOscY2t1MJaYYMuIYQCIgRa0YV0+kZw3CWN92WpKs=;
 b=AXaULPmQWUXb0lJZOigCridcRbAUPGbMakry+siHRxyEXffOfb6XYEpxg6kDs7a8L0yTt+4RbrmlxwKlHam5wKstMsjqyWLZSMbYI0rfHO3708ocF6+6fsiu0OfWbJO5jmYrG+70pte0wpDLxP5+KjVqeQwlr+K5srcO6/+2a9cgG9l4yK+g4ySafk3YJADKgZVF1qpID+3HTrH6UGtpf0TbNhUcz2LBMjKAda6ziVl1rSYNKuC3qK2nC1M+hnMxoOGxNbNUp4CIAMs3KwttlVQbZD8SCZgHYkXoQcu/51J2t+xplmeKDGGIKhS2Yf9KBXsEQvpNZEek83eroKP/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Satananda Burla <sburla@marvell.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support
 access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAEEagIAAvVJg
Date: Fri, 4 Aug 2023 04:22:49 +0000
Message-ID:
 <PH0PR12MB5481669D591E1286732DC054DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <SJ0PR18MB44773DCEDDEF6B612F7BC5B7C308A@SJ0PR18MB4477.namprd18.prod.outlook.com>
In-Reply-To:
 <SJ0PR18MB44773DCEDDEF6B612F7BC5B7C308A@SJ0PR18MB4477.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7509:EE_
x-ms-office365-filtering-correlation-id: 5b4d20a2-34ef-4af4-260d-08db94a27633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Lh4j8XVmxOYlPHGYZCvPkfjajwvUL/rER0B8SiB6wpRZpSFfpe3oLw7XNW5K9BXRQjUx41n0SuS7nMo2DjcfjPpANFCqv3OzSYejh2gcNyQZQook5OAcMrADWQBv5Y3qjWTvLD0Sq82rn5DL/p4WwPds58AVx33x37Zb/lN3YvfL/cazkHP7ZQCLaHl0cYaPwt4ft8XiL29wqnpVOPNSP1oVPHty33jYbizMxuAHoQN+Tz312s+sB58C2dkz3tbLj2KVHZsmkFdmHSbedU5LQRRZTcxeghJzSQ+r/7mAkrG50JqUmar9vFnjF3O75BkQZAE2gJPbvjFEHiWzbrgkFEi7iAB8lWweX71mYtSfKQy9rft8blJyedYf0aAI8gDO8WIOdIBIr0sgHtqUBVTA21BK7qjH5KohlFLHpIOLVAE3P45+RmOloHpRiTbLZEMGAtL2LGkoXjcQ8TvDWFL2dF8leTxGHWahnjA7nWNWrz/icguzI4milJSxqywn/stnMYRe3hhECFWNhcfWxdqnopW/knpndNmVL2qnclRMTc4ymmZASNC5r3BXdhIn+yk9t0HemRFH69LW8B3fra2tE2xvpX9zg77D79atBFjUJVrj7oOtWkazs0la3TemHbAx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(1800799003)(186006)(451199021)(41300700001)(8936002)(8676002)(26005)(6506007)(86362001)(38100700002)(122000001)(38070700005)(316002)(4326008)(71200400001)(9686003)(66446008)(54906003)(478600001)(7696005)(110136005)(33656002)(55016003)(64756008)(76116006)(4744005)(2906002)(66476007)(5660300002)(66946007)(66556008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kQ9Hy8lB5H7VR6C803DgkrpYJGF8pTqtgWo/M/XM/jO7B7n9aQYQr3dz4Lkn?=
 =?us-ascii?Q?eR+p/Db8LQP67yrESGMm3o87ocwgDue7gttKVaFH/4vr8jn0K4tX7fVJ/WGl?=
 =?us-ascii?Q?l5yrECBXMNdLTVoTGGkK00Bqq2B4Kb+V45HgUzNYwNAUnAIBkrZcAm18peYP?=
 =?us-ascii?Q?9hA0HNTVQVcdq8ywdwSKiaBbi82xxBY476pbYCpux/x/SGUutD6aHFhu6jtX?=
 =?us-ascii?Q?SgWg+XijSyFgKEu/GS97nNwK/YaqD61HHdB0ldYywMut+ADM2HLq+DojfwOp?=
 =?us-ascii?Q?O/18gBmxHYlwvc1LdWdb6GDFxtqPTN15iKsohg8bRlqXbYFfuiOfhEX/Z9NE?=
 =?us-ascii?Q?36wzTDXa8UA5ImaG7Od12KXTKy+tOoA23q0T5L7xSba+AUdzU/MThzAE/AFV?=
 =?us-ascii?Q?pXS89Y7f8n4G/6V+nJOLJao7FuzmLXgwXosrA38DJ+UIOS9Va0EML+WC6ptK?=
 =?us-ascii?Q?6UFYwObVq1mtc8EoA3fCz7XF+nyaY+JcMs5h8qRqAAi19rovQlauvob6W6qV?=
 =?us-ascii?Q?KkHaMuo6gUETzBB6J+tyw3+IBZ0cLXvgS0poFDNmgBgwWwzMIyAIr9vhNnA+?=
 =?us-ascii?Q?TVj9oYl+hTdcx2fw7BtyUSMZpcmDDBAb1qd+TqDLzT32RFw6FB1ximJjFIjU?=
 =?us-ascii?Q?p1aeP2tVVxpBwRV8Q2kJ6LuJEnNnNJjqwVsrIiKX3fIfesI7N1ppMR4Qdi50?=
 =?us-ascii?Q?XDKtYteVG7OUKwlI2r3/N0xMqwE1zrKJX9XPu5nW0SjULxvRIHLPjVnPRLIW?=
 =?us-ascii?Q?EVvvvwMJir8q/Lag3NwnIZcQy+WsBtdhG/XobqpBKQcsSGB0pHBNQZ+/44EM?=
 =?us-ascii?Q?ZAzqjiJa63n4JUmwtjR6J1QnrwANnhB5cp85whe4czEG3sIw8/59GRzXEl5+?=
 =?us-ascii?Q?xSQhd+TC1H3ciHa8mfGzWP1AHugNUopFGGrledUHXOw1Hk3bwotUjWOZnVZD?=
 =?us-ascii?Q?tjnh0DU+w6CsRAIRFkiRKeJli20eXsPMlv17BC1ZPsARm4GKaaegNKb7RzuR?=
 =?us-ascii?Q?O5THqW98a7GmO+bgsGok7QN7zWvMDNB8juF6OIcayYVkn92jsflk38VTnd0F?=
 =?us-ascii?Q?TB2KE063QXoIEoG2C2a4+iQbmc8bqp9C4knwtg5J/R6lQ2576ucN15E8oGaA?=
 =?us-ascii?Q?FzbSpL7AG8nVioeWEfMc6Fee25RXRrojZbkhI4ky67vZRzMlzo3oR4vtQcEC?=
 =?us-ascii?Q?+3NU3NDxoeVlnPKc2ThrUQQKeMnvLxrGwqm2jjXgRM18+PvPVWxvag1bN2f8?=
 =?us-ascii?Q?0/tY5tPSsNKgFGz/5sHzb7AKP1yz4u7IHtJtbf8eU6P9ps6LMtDeaMnz69GG?=
 =?us-ascii?Q?JDcqmUBUKmnJFgQGn8P9VACUY40u2/Yn7zhtHbVJr7/Wqcvufuw2yrsZ6oeR?=
 =?us-ascii?Q?kgSCEsPVPJw+TOJQhhVrl0BVo01XuZYh0EGngoZxJpck2IZ/2ta+w7F5ZEJ/?=
 =?us-ascii?Q?LEc+/4MrTBqFAsglVn0CW08RI0jeFVNqlkhQFemOr6pWVe02Gcxdrc0RjTot?=
 =?us-ascii?Q?aPtwnldnkA3YQKKOFOfbEnLrAAVZNHH8dWc6G2eO9I1u3RLGODmOBVjrrUdX?=
 =?us-ascii?Q?wKxrsdZLPT4Fp19zEys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4d20a2-34ef-4af4-260d-08db94a27633
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 04:22:49.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+SOIqTLZmQTTNC35xxiOe5Wwr2w69ksKfJ+TSbeR0nDK/woVOiWoc/EOutvh4KdZ+BQ+92sxkqf9V6II+OMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
Subject: [virtio-dev] RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access
 and control the member devices



> From: Satananda Burla <sburla@marvell.com>
> Sent: Thursday, August 3, 2023 10:33 PM


> IMO, kernel already prescribes using representors for mac/vlan  programmi=
ng
> for SRIOV/SIOV eswitch devices, member devices may have to support
> representor interfaces.

Member device's representor switch port is on the owner (switch) device.
And flow filter entries are programmed on this owner (switch) device's flow=
 vq.
OS level representor is also on this owner (switch) device.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

