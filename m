Return-Path: <virtio-dev-return-13707-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C4CA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:28:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B131E602EE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:28:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A364998664C
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 09:28:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 977C6986490; Tue, 12 Sep 2023 09:28:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8797F98648C;
	Tue, 12 Sep 2023 09:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfpC4n9igU4iBlKfQgi2DInK+82xj3caG8XXdxSvrabWItLOw/d4N/rfahzjuLC9pfC8rJVY4VcuwMeh61Zs1SujqTFJBo52I8QpW7XIoHjJXP+urZrVMLPCCUwT8LvOa3A4i8qg/2OdXXn4t6hDWPa6CU+bP6ZzCLTeyANtXCBDIB3ssmg9kEY6zZDNu1YC+JFGUfiSyCMiMiLZhl6aBk8xORszMKDMB69gDZzJU0gPN5RwcZpZJZP41CKJO0tknB7otX2M6FbQ8z8hTJM6fn1Z2t7aEizg7xoAuxPFlSek+P+LKw+ZnT58FB+lbgDHeseC4/pjhnvXlg6AuIj1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUmUaeFF9b1eI8QL01W/9k2XqPNHuHWR/P3wJfzWefE=;
 b=TYKZ5fCRLUKnsLF1lwFvoohEhPCDLD8GiQnTfJGvoowb+x0FNwqs60dKByRc30P4FsYq9vO9U9WoloxLE0UU/rH4gYDiMKuk3BS6Oa800JSHnSb0G2oDmZzEwcIZQkZU8f+C+8CnBEv7fjDSKewChF8xVdIod+mvy6Eqiw3m5ujDoVndJRyp5E1Kwz00fVoJmc2CB7y1ghvcywE6zcgG0WEeoF5NemEKeHQ2iZyMUEWlu0eEKWNE1EE8lbjn6QtUpYACMdh17YbEeAREHMyVKRSzwtfPaWC+oMYuUpd9qav0Y5NKIb3tyLjK+Jl1oYz6OrQfkredgFFiX05pfXlVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAABGsg
Date: Tue, 12 Sep 2023 09:28:12 +0000
Message-ID:
 <PH0PR12MB5481036BC22785DC22A394D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
In-Reply-To: <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6146:EE_
x-ms-office365-filtering-correlation-id: 3a193157-b1d8-454d-ece2-08dbb3729600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E6KAXMKl/9eX5mcOLYdX4igjbf1cEWKlioaahFi3PZBdDdS9sgoXS3VkY//tD0zYNhrv2hWqwoHuUtN9n2QLI4bqjiIsq5QJ618puyZJFcIatJOWJ7HosF4Me8a9iPlwIg1TEwV9HZMQvjDsh6G4Tt+z74QLLJmBYWalk0cwMniO/+/XWyEkCVfY6M0ZiuVgmbQ1kG+qajeXoCVCTrf3BOVcihzF57RTmY2VORP68xFmZaF5Yv+9PLNzuIQ2NsfDFI9eo/LslPWoiRlv10sa/B8GOJO277xIifOt1z7ddZuYB1uAI7NN0GErRNjv/6ftRfvS4sMbgJWykyKRwUKOcVvQydKIw/HY5dir7l+nJSXHOcrwEHOqdNwzWq0HyV+fFq4SsGDgdkXhMn6R/M/hcuZjPZMsXvYfQp/TeV/iad+DK0B7CDrs9YuxM0hNAjO8B0ZA+jbRerZor2B9GVTTl9i/ymnXbjoxzP32cg6QRfQq9S4ogLmhWOwS3DBVfR9mx1D+rSyrCcyWKYixgsPgx777K2+ws1lGDPQ04V8P1EVNz8tQH4uENc886F29shWZYo7gmO7Ax7m+hTqW2lRo29ImVUFNMhVbA4o3qNBpVf0MIrbcVzL53ziHVWobYxFC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199024)(186009)(1800799009)(6506007)(7696005)(9686003)(71200400001)(83380400001)(38070700005)(122000001)(33656002)(86362001)(38100700002)(55016003)(26005)(52536014)(316002)(41300700001)(4744005)(2906002)(76116006)(66946007)(66556008)(4326008)(54906003)(110136005)(66476007)(64756008)(66446008)(8676002)(5660300002)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm5rZysxUWYrSWcrWkMzYUdsY3lWUUhnWWhOaFF2cWhzMnpmd3BnSHJTZnJm?=
 =?utf-8?B?eS9FYWxxNkZ2cGtsMDJZc3JQZ0RzMHQ0RllkOUMxWFFIQ3lWWU9EcFA5bSt4?=
 =?utf-8?B?b1VDWnA5bzhKMUw2c0hNcTh5QndEb3lTNGJvTkZFelYwT3lSaEQ1UG5KTTZE?=
 =?utf-8?B?dENrQWQ3cGw4ak1kdHRabkpqSmovNkV3ejVmYThZRkcvaVJ4eWpDMGcwOWUz?=
 =?utf-8?B?YWFYaWl6VjBPQlhRSDdtWncya3ZiclZNRmlsUiswZFgwenByd3F4emxKdWs1?=
 =?utf-8?B?RVRGZHZxb1dFSjY4SFlqb0FsaFUrWDRsQzV4bWNpZGZpS2JJQTNsWDNncEtI?=
 =?utf-8?B?cmJvMDl2OWVUMUZrUDJCdnh1bTRWVThSQ1FYRW1NUU93NEZuNTlHTXphekRn?=
 =?utf-8?B?Nnh2UnhhN2RzNmVBVWZJL3psWnQ1b0dGbE5zTUJJaFo4WjFnZHQxMW00cDEy?=
 =?utf-8?B?WmdVQ09vMW0xZUxOM2o0YW9CeHVwQTc2RUtFRm9yV1AzMHoyYXZjU0swSXlm?=
 =?utf-8?B?T0tDYWlkSUtoWGpPb1FJRTQ1UFNrYlJCS0ZPdTdWN3MySlFtR21uR3VzYjdi?=
 =?utf-8?B?QmRpemp1MW00TlRZekJVT3U2a2FZZ1E1ZC9oVTY0M3o1d25CYUQzNUh4K05V?=
 =?utf-8?B?TlMyTGZFSVdUZ0hFNUJCWnRadnQxdUJsVXMrMG4yVytoenNLWGNUcXFwMkww?=
 =?utf-8?B?OVpSK1BucWlZNVhuRklvcmlwcVR3a3d0ZEI5dUZQMTkzM1Q3eGJUNHNUVi9o?=
 =?utf-8?B?OW9mRHE3S2h0Z2R1SEFsK1VVL1VvZzIxSUxpa3hHUzRhMTlzNUp0dU5zNTJq?=
 =?utf-8?B?Mk1uRVNSLytZRmV5VStlclgrMlI5ZHQzbndFd0l3VnFYbkgxWEltU3pJd3ZW?=
 =?utf-8?B?ZHY3ejg1NjJtQmI3bEw5M05ZRHBkUC9jYTQ0c1RYZDZnckxvVjM1VmRvR3JT?=
 =?utf-8?B?QnJiYTA0M2x4TEUxbGlwWncyY0xiNDRZWTdjK1lQVHhSZFlPd1VIdFJGZTVi?=
 =?utf-8?B?MDFBL1hKV3JoVmlQK0cyWW0xbXRYZTJnTVlKeFc5eFhVRFRQU1ZhTStFSkJn?=
 =?utf-8?B?VGNKVDduZEs0ejUxNEZBbDh0bU1rNStvM1ZYcXUwcGtKSmhDVThBREUxaFBh?=
 =?utf-8?B?amJ6WmtMNjRqMzlnY0pic2t4THNCankzdTh0b0R1SmlTWFZ2K0xXOVNYZ1hj?=
 =?utf-8?B?VHFhR1c5NzlwOStNMFZ1aVZnaC95VTVaNkZ0ckFmQTF2TVFDb1NaSlVjY1Zl?=
 =?utf-8?B?NWQxTGUvdnVDYXFZSit6SldUVEZnNGZYSXRoQUhNL2FTckJrdkJGbCsxMVY2?=
 =?utf-8?B?VGUxcjBQSllsUXFscFJ5WW9WZWNXZGd5RXJvTzNUb2l2ako1Q1diMjBlTWU2?=
 =?utf-8?B?clZ6VHFsSUxrQlZGK0FmOS9aY3YybjJlNUZWK015RFdwTzJaS1NxNzlZNENS?=
 =?utf-8?B?YUNUOWVZZnJWQUU3S0FaOWhveTgxcnZnTlhHczBQZDhneWJ1YlpkUU05aGRR?=
 =?utf-8?B?SlBROEp2VXBXV0o3TlVMTEhVSjF4MVdBN01RRTJDUm90eStldGFUSWJidGNp?=
 =?utf-8?B?OUZucUFMV3hrcnViQitTc01MTHNhaS9Ma2tURkJzdFpmeEUvTzU3OWNoUDFl?=
 =?utf-8?B?T1FjN2o2NTZLT21xeGhIbUE2dk93elpVWE9zWXo1eVc5Mnl5T3YxUGx0TktB?=
 =?utf-8?B?RUFTT0t0cnlTVkpCTnVJS0dxM0w1cnc1eDZwdmFlSVVuTER3NFJFQnBnWUFx?=
 =?utf-8?B?bHJla3BnSmtpL0Y3ak5LSDEzbTl0T0JaZzh2NkVteURSWm9wVDRiNmxUaExE?=
 =?utf-8?B?VTZySC8ySE1haHdFOWtBckRoYngwSktadzFVZWFoUzJkZVlSV0Q2OWNQcGF5?=
 =?utf-8?B?QkttVDMzZCtxcW0yOGtzK29Nc2NjWWpCVlh5eGZkSlhBNy90R1oyZlk5QTZP?=
 =?utf-8?B?ZExDTURleWtEd3c4UEhCcHFWSXdMK0l5QlllMzFOVTZEcWt5OVBmdUVSTXB2?=
 =?utf-8?B?ZGlaYW8zamZqTE1mbmd5a1JWaUNBTlNnaHVxa0c2T1FSM1BlY1QxbDRMK1Zj?=
 =?utf-8?B?d1ZZWndLQUtsVFJpRHlqNlhoQ3BVOFBadERXVTRidHVXZmcvamNiWWZ2Y3pQ?=
 =?utf-8?Q?e3zE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a193157-b1d8-454d-ece2-08dbb3729600
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 09:28:12.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SGdHMO2QjHdYvcUc1KFseopqXIY6xoyl8lg1bzM1FM9KdFShfaTFYIdgedPkRfaAHa0QwFgSz8yw3JSjCWSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAyOjM2IFBNDQoNCj4gSWYgeW91IHdhbnQgQVEg
dXNlZCBmb3IgTE0sIGl0IHNob3VsZCBzdXBwb3J0IG5lc3RlZCBhbnl3YXksIGRvbid0IGJyZWFr
IHVzZXINCj4gbG9naWMuDQpZb3UgaWdub3JlZCB0aGUgb3RoZXIgcGFydCBvZiBteSBxdWVzdGlv
biB3aGVuIHlvdSBhc2tlZCBhYm92ZS4NCmkuZS4gYSBQQ0kgdHJhbnNwb3J0IGRvIG5vdCBhbGxv
dyBzdWNoIHdlaXJkIGJpZnVyY2F0aW9uLg0KPiANCj4gDQo+IFRoaXMgKG15KXNlcmllcyBjYW4g
c3VwcG9ydCBuZXN0ZWQuDQpNYXliZSBpdCBkb2VzLCB3aXRoIGhhY2tpbmcgdGhlIGRldmljZSBy
ZXNldCBhbmQgRkxSIHNlcXVlbmNlLCB3aXRob3V0IGRpcnR5IHRyYWNraW5nLCB3aXRob3V0IFAy
UCBzdXBwb3J0LCB3aXRob3V0IHBhc3N0aHJvdWdoIG1vZGUuDQpBbGwgdGhlc2UgcmVxdWlyZW1l
bnRzIGFyZSBub3QgYWRkcmVzc2VkLg0KDQpJZiB5b3UgaW50ZW50IHRvIGNvdmVyIGJvdGggcmVx
dWlyZW1lbnRzLCBsZXRzIHdvcmsgdG93YXJkcyBpdCB0byBzZWUgaWYgaXQgY2FuIGNvbnZlcmdl
LCBpZiB0aGVyZSBhcmUgdGVjaG5pY2FsIGNoYWxsZW5nZXMsIA0KdGhlbiB0aGVyZSBpcyBubyBw
b2ludCBpbiBwdXNoaW5nIHRvIGNsYWltIHRoYXQgaW4tYmFuZCBWRiB3aXRoIG1lZGlhdGlvbiBp
cyB0aGUgb25seSB3YXkgdG8gbW92ZSBmb3J3YXJkLg0KDQo=

